- dashboard: facebook_overview
  title: Facebook_Overview
  layout: grid
  rows:
    - elements: [total_impressions, total_spend]
      height: 150
    - elements: [spend_actions_impressions]
      height: 400
    - elements: [campaign_performance]
      height: 400
    - elements: [campaign_value]
      height: 400
    - elements: [campaign_delivery]
      height: 400
    - elements: [campaign_performance_and_clicks]
      height: 400
    - elements: [avg_frequency_by_objective]
      height: 400

  filters:
    - name: campaign_name
      type: string_filter
    - name: date_start
      type: date_filter

  elements:

  - name: total_impressions
    title: Total impressions
    type: single_value
    model: dbc
    explore: facebook_ad_insights
    measures: [facebook_ad_insights.total_impressions]
    sorts: [facebook_ad_insights.total_impressions desc]
    limit: 5000
    show_single_value_title: true
    show_comparison: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: total_spend
    title: Total spend
    type: single_value
    model: dbc
    explore: facebook_ad_insights
    measures: [facebook_ad_insights.total_spend]
    sorts: [facebook_ad_insights.total_spend desc]
    limit: 5000
    show_single_value_title: true
    show_comparison: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: spend_actions_impressions
    title: Spend, actions, and impressions over time
    type: looker_line
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_ad_insights.date_start_month]
    measures: [facebook_ad_insights.total_spend,
      facebook_ad_insights.total_impressions]
    sorts: [facebook_ad_insights.date_start_month desc]
    limit: 5000
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: campaign_performance
    title: Campaign performance
    type: table
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.end_date, facebook_adsets.effective_status,
      facebook_campaigns.objective]
    measures: [facebook_ad_insights.total_actions, facebook_ad_insights.total_clicks,
      facebook_ad_insights.total_reach, facebook_ad_insights.total_spend]
    dynamic_fields:
    - table_calculation: cost_per_action
      label: cost_per_action
      expression: ${facebook_ad_insights.total_spend} / ${facebook_ad_insights.total_actions}
    sorts: [facebook_campaigns.name]
    limit: 5000
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: campaign_value
    title: Cost per action v. total actions by campaign
    type: looker_scatter
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_campaigns.name]
    measures: [facebook_ad_insights.total_actions, facebook_ad_insights.total_spend]
    dynamic_fields:
    - table_calculation: cost_per_action
      label: Cost per action
      expression: ${facebook_ad_insights.total_spend} / ${facebook_ad_insights.total_actions}
    hidden_fields: [facebook_ad_insights.total_spend, facebook_campaigns.name]
    sorts: [cost_per_action desc]
    description: 'Evaluate campaign performance by comparing the actions generated to the total spent on the campaign.'
    limit: 5000
    column_limit: 50
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: campaign_delivery
    title: Campaign delivery
    type: table
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.end_date, facebook_adsets.effective_status,
      facebook_campaigns.objective]
    measures: [facebook_ad_insights.total_reach, facebook_ad_insights.avg_frequency,
      facebook_ad_insights.avg_cpp, facebook_ad_insights.avg_cpm, facebook_ad_insights.total_impressions]
    sorts: [facebook_campaigns.name]
    limit: 5000
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: campaign_performance_and_clicks
    title: Campaign performance and clicks
    type: table
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_campaigns.name, facebook_adsets.effective_status, facebook_adsets.end_date,
      facebook_campaigns.objective]
    measures: [facebook_ad_insights.total_actions, facebook_ad_insights.total_reach,
      facebook_ad_insights.avg_frequency, facebook_ad_insights.total_clicks, facebook_ad_insights.avg_ctr,
      facebook_ad_insights.avg_cpc, facebook_ad_insights.total_impressions, facebook_ad_insights.avg_cpm,
      facebook_ad_insights.total_inline_link_clicks, facebook_ad_insights.avg_inline_link_click_ctr,
      facebook_ad_insights.avg_cost_per_inline_link_click, facebook_ad_insights.total_spend]
    sorts: [facebook_ad_insights.total_actions desc]
    limit: 5000
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date

  - name: avg_frequency_by_objective
    title: Average frequency by objective
    type: looker_column
    model: dbc
    explore: facebook_ad_insights
    dimensions: [facebook_campaigns.objective]
    measures: [facebook_ad_insights.avg_frequency]
    sorts: [facebook_ad_insights.avg_frequency desc]
    limit: 5000
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    listen:
      campaign_name: facebook_ad_insights.campaign_name
      date_start: facebook_ad_insights.date_start_date
