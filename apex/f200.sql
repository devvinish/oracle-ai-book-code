prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>11162471953618408
,p_default_application_id=>200
,p_default_id_offset=>0
,p_default_owner=>'ATLAS'
);
end;
/
 
prompt APPLICATION 200 - Atlas Support
--
-- Application Export:
--   Application:     200
--   Name:            Atlas Support
--   Date and Time:   14:52 Friday October 2, 2026
--   Exported By:     ATLAS
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     11
--       Items:                   31
--       Validations:              3
--       Processes:               14
--       Regions:                 31
--       Buttons:                 17
--       Dynamic Actions:          4
--     Shared Components:
--       Logic:
--         Build Options:          1
--         AI Agents:              2
--       Navigation:
--         Lists:                  3
--         Breadcrumbs:            1
--           Entries:              8
--       Security:
--         Authentication:         2
--         Authorization:          1
--       User Interface:
--         Themes:                 1
--         Templates:
--         LOVs:                   4
--       PWA:
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         26.1.0
--   Instance ID:     2600172728634599
--

prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'ATLAS')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Atlas Support')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'ATLAS-SUPPORT')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'90F1174CFA2EB827AFB094DFC41E9BFB685998B987610E81206947F3CA1FF784'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'26.1'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_flow_image_prefix=>nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>wwv_flow_imp.id(11383355432088161)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Atlas Support'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_vpd=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the users of Atlas Support are agents: they may retrieve internal documents',
'atlas_security.set_audience(''Agent'');'))
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Atlas Support'
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>2461316090627
,p_version_scn=>'14531807'
,p_print_server_type=>'NATIVE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
,p_ai_remote_server_id=>11164128359710547
,p_ai_req_handler_procedure=>'ATLAS_AI_REQUEST_HANDLER'
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(11384241504088164)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>2469215554099805162
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(11385016992088178)
,p_nav_bar_list_template_id=>2849019392706229583
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --workspace/credentials/credentials_for_gemini
begin
wwv_imp_workspace.create_credential(
 p_id=>11163769347710540
,p_name=>'Credentials for gemini'
,p_static_id=>'credentials-for-gemini'
,p_authentication_type=>'HTTP_HEADER'
,p_valid_for_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'https://generativelanguage.googleapis.com/v1beta',
''))
,p_prompt_on_install=>true
);
end;
/
prompt --workspace/remote_servers/atlas_minilm
begin
wwv_imp_workspace.create_remote_server(
 p_id=>11502018688172262
,p_name=>'Atlas MiniLM'
,p_static_id=>'atlas-minilm'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('atlas-minilm'),'https://localhost')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('atlas-minilm'),'')
,p_server_type=>'VECTOR'
,p_ai_model_name=>nvl(wwv_flow_application_install.get_remote_server_ai_model('atlas-minilm'),'')
,p_ai_http_headers=>nvl(wwv_flow_application_install.get_remote_server_ai_headers('atlas-minilm'),'')
,p_ai_attributes=>nvl(wwv_flow_application_install.get_remote_server_ai_attrs('atlas-minilm'),'')
,p_ai_max_tokens=>nvl(wwv_flow_application_install.get_remote_server_ai_maxtokens('atlas-minilm'),'')
,p_embedding_type=>'ONNX'
,p_emb_local_model_owner=>'ATLAS'
,p_emb_local_model_name=>'ALL_MINILM_L12_V2'
,p_prompt_on_install=>false
);
end;
/
prompt --workspace/remote_servers/gemini
begin
wwv_imp_workspace.create_remote_server(
 p_id=>11164128359710547
,p_name=>'Gemini'
,p_static_id=>'gemini'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('gemini'),'https://generativelanguage.googleapis.com/v1beta')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('gemini'),'')
,p_server_type=>'GENERATIVE_AI'
,p_credential_id=>11163769347710540
,p_ai_provider_type=>'GEMINI'
,p_ai_is_builder_service=>false
,p_ai_is_default_for_new_apps=>true
,p_ai_model_name=>nvl(wwv_flow_application_install.get_remote_server_ai_model('gemini'),'gemini-flash-latest')
,p_ai_http_headers=>nvl(wwv_flow_application_install.get_remote_server_ai_headers('gemini'),'')
,p_ai_attributes=>nvl(wwv_flow_application_install.get_remote_server_ai_attrs('gemini'),'')
,p_ai_max_tokens=>nvl(wwv_flow_application_install.get_remote_server_ai_maxtokens('gemini'),'')
,p_prompt_on_install=>false
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11379276648088157)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
,p_version_scn=>'SH256:NcagEyRP_F17oe14bnrSYSYienkBgpdRSvH17g_NxoE'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11382297419088159)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'mode', 'FULL')).to_clob
,p_version_scn=>'SH256:FJR60MFzlfEjx0PvnpYBK4631rNeUHXaF3eGFKxcTgE'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11379514727088158)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'show_on', 'FOCUS',
  'time_increment', '15')).to_clob
,p_version_scn=>'SH256:dQTHqehcDG0h-d-qmHe5lf-DuViElEHDw9zMkscLr6M'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11379804674088158)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'background', 'default',
  'display_as', 'LIST',
  'map_preview', 'POPUP:ITEM',
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
,p_version_scn=>'SH256:CU9J9l4sUtY-UffjdBCosfDW6ER-I0swXpw8GekLiYQ'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11381938024088159)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_values_as', 'separated')).to_clob
,p_version_scn=>'SH256:jJTPfH8wphTXe7ahDytF6PbWlPl1mXrDRYylCDda0k0'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11381346614088158)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N')).to_clob
,p_version_scn=>'SH256:oAqKgc-cSRXHDMjfwwNIgo78WqYXKjQz8MWGBG6Euj0'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11382548051088159)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'default_icon', 'fa-star',
  'tooltip', '#VALUE#')).to_clob
,p_version_scn=>'SH256:uT4QhQbZQY61UFxAGl7ieo2urrCo8jUsFNprrg7lGHo'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11382875533088159)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_style', 'SWITCH_CB',
  'off_value', 'N',
  'on_value', 'Y')).to_clob
,p_version_scn=>'SH256:wAjuCAsVhoIbbuKGWTMQ__Rd_YS_sY9KgWhpqOO11mc'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11381058071088158)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
,p_version_scn=>'SH256:GIeRbUJQ8yKfen6-dFvkghmSUZXFoUAXCCTNRhCJgh0'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11378905447088152)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'Y')).to_clob
,p_version_scn=>'SH256:4M27aN0U-JyQ0prILtI8ITLXOphqUdO-xWNcwkSL1SI'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11381665975088158)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
,p_version_scn=>'SH256:tNGqNT-VaoKqWOwKbAdEqb6C0QO-GMcYRZJLXjScHMo'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11380179703088158)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'Y')).to_clob
,p_version_scn=>'SH256:vJP7K77hiNj1R2RE6dHVyRAhlmxDg6KGn4yRE20J9Qw'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11380710329088158)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
,p_version_scn=>'SH256:fiSZ-OfcUl-d0e0dtJUYffG7q61xKsHlomsv7ZU1BMw'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(11380451940088158)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_BOSS'
,p_version_scn=>'SH256:dRkCWi6vQMhdQUSqb0QlRls9iYcsZ93IPYrbTqFqJFE'
);
end;
/
prompt --application/shared_components/ai_agent/atlas_assistant
begin
wwv_flow_imp_shared.create_ai_agent(
 p_id=>wwv_flow_imp.id(13366944066512216)
,p_name=>'Atlas Assistant'
,p_static_id=>'atlas-assistant'
,p_system_prompt=>'You are the support assistant of Atlas Software. Answer questions about Atlas products only from the results of the tool search_knowledge_base, and name the sources you used. If the results do not contain the answer, say exactly: I could not find thi'
||'s in the Atlas knowledge base. For questions about a ticket, use the tool get_ticket_status. Answer in plain text, in at most four sentences, in the language of the question.'
,p_welcome_message=>'Hello! Ask me about Atlas products, or about one of your tickets.'
,p_temperature=>0
,p_version_scn=>'SH256:_bCBdno99a-5HvUVmlrAtdGzDOjWhNh2G521zsBoj-c'
);
wwv_flow_imp_shared.create_ai_agent_tool(
 p_id=>wwv_flow_imp.id(13367913324547889)
,p_tool_name=>'get_ticket_status'
,p_static_id=>'get-ticket-status'
,p_tool_type=>'NATIVE_RETRIEVE_DATA'
,p_execution_point=>'ON_DEMAND'
,p_description=>'Returns the subject, status, priority, and creation date of a support ticket.'
,p_requires_confirmation=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'data_description', 'One support ticket',
  'sql_query', 'select ticket_id, subject, status, priority, to_char(created_at, ''YYYY-MM-DD'') as created from tickets where ticket_id = :TICKET_ID',
  'type', 'SQL_QUERY')).to_clob
);
wwv_flow_imp_shared.create_ai_agent_tool_param(
 p_id=>wwv_flow_imp.id(13368273529547891)
,p_param_name=>'TICKET_ID'
,p_description=>'The number of the ticket'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
wwv_flow_imp_shared.create_ai_agent_tool(
 p_id=>wwv_flow_imp.id(13367266317546063)
,p_tool_name=>'search_knowledge_base'
,p_static_id=>'search-knowledge-base'
,p_tool_type=>'NATIVE_RETRIEVE_DATA'
,p_execution_point=>'ON_DEMAND'
,p_description=>'Searches the Atlas knowledge base and document library for the passages nearest to a question. Returns the source name and text of each passage.'
,p_requires_confirmation=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'data_description', 'Passages of Atlas articles and documents, with their source names',
  'sql_query', wwv_flow_string.join(wwv_flow_t_varchar2(
    'select k.source, k.text',
    'from   knowledge k',
    'order  by vector_distance(k.embedding,',
    '            vector_embedding(all_minilm_l12_v2 using :QUESTION as data), cosine)',
    'fetch  first 4 rows only')),
  'type', 'SQL_QUERY')).to_clob
);
wwv_flow_imp_shared.create_ai_agent_tool_param(
 p_id=>wwv_flow_imp.id(13367539366546078)
,p_param_name=>'QUESTION'
,p_description=>'The customer question, in their own words'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
end;
/
prompt --application/shared_components/ai_agent/atlas_triage_agent
begin
wwv_flow_imp_shared.create_ai_agent(
 p_id=>wwv_flow_imp.id(14166989233632689)
,p_name=>'Atlas Triage Agent'
,p_static_id=>'atlas-triage-agent'
,p_system_prompt=>'You help the support agents of Atlas Software manage tickets. Before you act, look up the tickets with the tools; never guess a ticket number. To change the priority of a ticket, use set_ticket_priority. Report what you did, or why you did nothing, i'
||'n plain text, in at most three sentences.'
,p_temperature=>0
,p_version_scn=>'SH256:A-mwCc0sjg5WXeNJ9FfhqKUQPNICRw5pHBkaYtTQ8uo'
);
wwv_flow_imp_shared.create_ai_agent_tool(
 p_id=>wwv_flow_imp.id(14167162829634471)
,p_tool_name=>'list_open_tickets'
,p_static_id=>'list-open-tickets'
,p_tool_type=>'NATIVE_RETRIEVE_DATA'
,p_execution_point=>'ON_DEMAND'
,p_description=>'Lists the open tickets of a customer company: number, subject, priority, status, and creation date.'
,p_requires_confirmation=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'data_description', 'The open tickets of one customer',
  'sql_query', wwv_flow_string.join(wwv_flow_t_varchar2(
    'select t.ticket_id, t.subject, t.priority, t.status,',
    '       to_char(t.created_at, ''YYYY-MM-DD'') as created',
    'from   tickets t join customers c on c.customer_id = t.customer_id',
    'where  upper(c.company) = upper(:COMPANY)',
    'and    t.status in (''Open'', ''In Progress'', ''Waiting'')',
    'order  by t.created_at')),
  'type', 'SQL_QUERY')).to_clob
);
wwv_flow_imp_shared.create_ai_agent_tool_param(
 p_id=>wwv_flow_imp.id(14167456076634474)
,p_param_name=>'COMPANY'
,p_description=>'The name of the customer company'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_ai_agent_tool(
 p_id=>wwv_flow_imp.id(14167915513665303)
,p_tool_name=>'set_ticket_priority'
,p_static_id=>'set-ticket-priority'
,p_tool_type=>'NATIVE_EXECUTE_SERVER_SIDE_CODE'
,p_execution_point=>'ON_DEMAND'
,p_description=>'Changes the priority of an open support ticket.'
,p_requires_confirmation=>true
,p_confirm_title=>'Change the priority'
,p_confirm_message=>'Set the priority of ticket &TICKET_ID. to &PRIORITY.?'
,p_confirm_approve_label=>'Change'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'language', 'PLSQL',
  'plsql_code', wwv_flow_string.join(wwv_flow_t_varchar2(
    'declare',
    '  l_old tickets.priority%type;',
    'begin',
    '  select priority into l_old',
    '  from   tickets',
    '  where  ticket_id = :TICKET_ID and status not in (''Resolved'', ''Closed'')',
    '  for    update;',
    '',
    '  update tickets set priority = :PRIORITY where ticket_id = :TICKET_ID;',
    '  insert into ai_actions (done_by, ticket_id, action, old_value, new_value)',
    '  values (:APP_USER, :TICKET_ID, ''Priority'', l_old, :PRIORITY);',
    '  apex_ai.set_tool_result(',
    '    p_result               => ''The priority of ticket '' || :TICKET_ID || '' changed from ''',
    '                              || l_old || '' to '' || :PRIORITY || ''.'',',
    '    p_notification_message => ''Ticket '' || :TICKET_ID || '' is now '' || :PRIORITY || ''.'');',
    'exception',
    '  when no_data_found then',
    '    apex_ai.set_tool_result(',
    '      p_result => ''Ticket '' || :TICKET_ID',
    '                  || '' does not exist or is closed. Nothing was changed.'');',
    'end;')))).to_clob
);
wwv_flow_imp_shared.create_ai_agent_tool_param(
 p_id=>wwv_flow_imp.id(14168250955665307)
,p_param_name=>'PRIORITY'
,p_description=>'The new priority'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_allowed_values=>'["Low","Normal","High","Urgent"]'
);
wwv_flow_imp_shared.create_ai_agent_tool_param(
 p_id=>wwv_flow_imp.id(14168701672665307)
,p_param_name=>'TICKET_ID'
,p_description=>'The number of the ticket'
,p_data_type=>'NUMBER'
,p_is_required=>true
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(11385016992088178)
,p_name=>'Navigation Bar'
,p_static_id=>'navigation-bar'
,p_version_scn=>'SH256:vnb1-G39r80BPE-5P2Enpuf0sMSVvBeNQDVbFiNwRto'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11475991765088297)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_static_id=>'app-user'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11476590809088298)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_static_id=>'list_item'
,p_list_item_link_target=>'separator'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(11475991765088297)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11477086657088298)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_static_id=>'sign-out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(11475991765088297)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(11384241504088164)
,p_name=>'Navigation Menu'
,p_static_id=>'navigation-menu'
,p_version_scn=>'SH256:Gxd3h00vPOwl7ifBIkyF22lrskV7896UGX848CTDrbQ'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(15167006888207538)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Ask Atlas'
,p_static_id=>'ask-atlas'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-question-circle-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(15967027848614512)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Ask Your Data'
,p_static_id=>'ask-your-data'
,p_list_item_link_target=>'f?p=&APP_ID.:13:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table-search'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'13'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11398430194088195)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_static_id=>'home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11433252770088274)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Knowledge Base'
,p_static_id=>'knowledge-base'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(15168480629212153)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Knowledge Gaps'
,p_static_id=>'knowledge-gaps'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-search-minus'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'11'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11564271339359372)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Search'
,p_static_id=>'search'
,p_list_item_link_target=>'f?p=&APP_ID.:8:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-search'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'8'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(15567025675511707)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Ticket Workspace'
,p_static_id=>'ticket-workspace'
,p_list_item_link_target=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-briefcase'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'12'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11399903176088197)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Tickets'
,p_static_id=>'tickets'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/page_navigation
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(11473198219088295)
,p_name=>'Page Navigation'
,p_static_id=>'page-navigation'
,p_version_scn=>'SH256:tmEKRhfU5vo8AxJadkO7CaTiBV2XS9J9V5ebsRCE15Y'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11474184113088295)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Knowledge Base'
,p_static_id=>'knowledge-base'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(11473687657088295)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Tickets'
,p_static_id=>'tickets'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/icons_app_icon_144_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000090000000900806000000E746E2B8000008BC494441547801EC9C4D881C4514C7AB57D69040847C9883848004B37E207812C14312C82228C68B67B37AF52A0839D8BB1E028257AF9AF5ECC588826C208920';
wwv_flow_imp.g_varchar2_table(2) := '78122F6A361294103C4413C540425CCCD8FF99ADA467D23B53DDF5AABAFBD57FE06D7FD5AB7AEFFF7E5353D3D3C99CE18B0A782840803CC4A3AB3104881478294080BCE4A3330122035E0A10202FF9E84C80C88097028D01F21A95CE6A1420406A4AD94E';
wwv_flow_imp.g_varchar2_table(3) := '2204A81DDDD58C4A80D494B29D4408503BBAAB199500A929653B8910A0767457336A7C80664877EAEC1B87CAB6F2F5D2ABA95B598F19F245BFDC3A40CB6B4B4756D69696DF5F3B716E65EDC4606390AD97CDCC0DCEA46E653DA011F48241BBE8C44C0CD8';
wwv_flow_imp.g_varchar2_table(4) := '0A4048DC029399C1396306F9C09823862F470506B92934837665A01C9D459B4505C88283C4098C641D47405998247B9ED557148030DD22398233AB1C12D70739B486E612BDCDEA233840A344F00E99150AAFCB2A0090969665FB7CB0B76000D98F2B7C56';
wwv_flow_imp.g_varchar2_table(5) := '3F382CCFC451609063AD895A841A2F08400858FEE32A9404BAFBC55A13B5404D42642A0E100245C02182659FCD15404D509BE63D547B8A0334577CBDAC1E8A67DB5620446D4401C282195366DB4271FC6A05501BD4A8FA6AB3B362008D02E3B7AD666588';
wwv_flow_imp.g_varchar2_table(6) := 'E925FBED4C0C207EDB8A0981EF58726F74118046B38F6F52F48FA980D4825A04A08ECF3E31EBD29BB1A416D4DE0071F6E90D33638162412D310B79033416150F7AA580C42C240090DC82AC57EA2B0816B3906F1A5E00494C81BE09D0DF4F01DF1A7A0194';
wwv_flow_imp.g_varchar2_table(7) := 'F12130BFEA75C0DBB7865E0075207F86E0A940F11BD9619F2E3C01D2BDFEF111B62FBEBEEBA0C600E15F0AF44524C6395D019F5A3606687A48BC9A8A020428954A07CAB331401BFFCD2D048A89DDF64881C600F52847863A43019FC98000CD109797A72B';
wwv_flow_imp.g_varchar2_table(8) := '4080A6EBD3EC6A425EEA00FAF7F686B97EF59FA876F3FA2D034B889B7BA9AA020845FCB380E74E01514CBB79E3B6195A01D23D6513D9510310E04111170E3C63DE3E7ED27C70E293E086B1C0C993079F368FEEDE9724446A00422161071F7BCA1CD8F504';
wwv_flow_imp.g_varchar2_table(9) := '76A3D9C1FD0BE6F9675F4C122275003DBEEF50347026074A112275004D1635F6716A1011A00084358728403081BB244081044E052202140820749B02440408950E68DA21224001E1B15D6B868800D92A7B6CFFBE797DA6771922FCDC32D3A1270D089047';
wwv_flow_imp.g_varchar2_table(10) := 'A18E3DF7DAD0FBD26F17CDE5ABEB06204DB33DBBF60EDBDFB9B531DC6AF843803CAA883BDE2FBFF0BAF9E3C63573F1F24FE6DBEFBF996A68E331DC34D7D6AE11204FE90F2FBC620091AB790ED739770224501240E4626DFECC229066651704A852169E74';
wwv_flow_imp.g_varchar2_table(11) := '558000B92AC576950A10A04A5978D2550102E4AA14DB552A40802A6531E6E3731F9A0BEB5F6E7155CF69DF4C085085828067FDCA8F15578CB9F2D72F4E56E9ACF024019A28AA8507CF3BE3AB79F932E0F9E8CC29E362685BF6D5BA4F804A952DC3F3D6D1';
wwv_flow_imp.g_varchar2_table(12) := '774A5746BBF6CEB3CB4D43B41D79E9FE4B8036EB3B0B9ECD6606B3928BD9F6DAB7C900346D41EC0A8F76189AE4970440588F7CF5DD67C36F569322119E4945EA1D270110D62358B7E09B1580B112611FE7B060AE5AF3D876E52D7C5C0CD096FDD4ED6F26';
wwv_flow_imp.g_varchar2_table(13) := '940440C815EB96324480A02E3C80023E2EF6EBB54B1856BD2503102A59860810D49979E08F99CCF59F4C632CF868B7A40042315158CC4475E1812FED4105920308120022D7350FDAD3B656204980B6968357EA2A4080EA2AC6F6630A10A0313978505781';
wwv_flow_imp.g_varchar2_table(14) := 'FA00D51D81ED552B40805497377C720428BCC6AA4720405B941777AAA7FD00BB855B72A7095045C9010FEE54575C727A1A113F7954F96A3C478026AA6AE1C19D6ADC702C5F06182E4F23A20DDA967DB5EE13A05265CBF054DDA9C66F61F819C4C5D0B6D4';
wwv_flow_imp.g_varchar2_table(15) := 'B5DADD8800755BC359F0D8E8312BB9986DAF7D9B0C40D316C4AEF06887A1497E490084F5089F486C82C76C9F2400C27A04EB167CB3C26C6365C13ECE61C15CB5E6B1EDCA5BF8B818A02DFB69DD4F0220140FEB96324480A02E3C80023E2EC62712A1BA32';
wwv_flow_imp.g_varchar2_table(16) := '2B430408EACC3C900233199F488412F72D9919C8A66C21AA0B8FF5E7765C813E00341EB1C01120725DF3080CA7BA8B2401525DD1C8C911A0C8826B1B8E0069AB68E47C085064C1B50D4780225654E3BD2135006DDB313F44E1EC0F9F0F9FD9191E74E80F';
wwv_flow_imp.g_varchar2_table(17) := '6E425EFEFDE70E4524138A1A801EDE3E6F76EEDE6E708310CFE3BCBBFAA6E9922126C4861877EED92153BD0EF4A206206889C2A040DB0A98BA687BF73F62102362D562AA00425150A03D45A1BA68982511A326530790A6E2F4211702D4872A7538C6C600';
wwv_flow_imp.g_varchar2_table(18) := 'CD3F7477BDC37931B4480A340628527C1C2682023E930101AA2A10CF392B40809CA562C32A051A0374F2D8A769FC2F9255AA293BE753CBC60041C3CC98F386AF9E2B90ADF824E005D0C064177C06A76FFF15F004C8700632FD7E0D3C3F45BC005A5E3C4D';
wwv_flow_imp.g_varchar2_table(19) := '80FACD8FF1ADA11740D08EEB20A860AD6FDBCC6BFD836CBD01BA6BFC834020B47E2AE00D10A640CE42FD2C7EBE787AD937726F8010006721A8D03793F9E4100108B350DFE44B3D5E89D9071A8A00848E0CD742A63F2F99D907F98A0134225A2E3004470B';
wwv_flow_imp.g_varchar2_table(20) := 'A140B632AA954CDF6200211C04C6053594A86D511C501BD44872305180101817D450A19B16A236E20061413D30D9D16E4A986E54A8096A23AD80384008108122604C9938A6B5A7006A805AA02621A20802100245C0EF2DAE163351E67DBB1CFDD19A2890';
wwv_flow_imp.g_varchar2_table(21) := 'ADA006A845136F179F6000D9C1478B364264F588B7CD44BF6D6D15777080303020CA17578BD99420418F5056087C1E1F57D03A17F899C225CE2800D94090547E0F24C26475F1D9C2D78213FAE30A634D5A5480ECE079F1EE18D96A86778C19DEC52650C6';
wwv_flow_imp.g_varchar2_table(22) := 'F105604CA119B4CB8B37641BE098CD572B006D8E3DDC60819797809ACF060BD6CCDDEC78EA66B5B0DB7C1398BCD00CDA0D456CF14FEB004DE68E7F21602D7FE9F417A99BD5C26E27F56AFBB87300B52D08C7AFA70001AAA7175B4F2840802604E1613D05';
wwv_flow_imp.g_varchar2_table(23) := '08503DBDF4B416CA84000909996A370428D5CA0BE54D8084844CB51B02946AE585F226404242A6DA0D014AB5F2427913202121D3E9663C530234AE078F6A2A40806A0AC6E6E30AFC0F0000FFFF47E6E62C000000064944415403006A459D7B97906FC100';
wwv_flow_imp.g_varchar2_table(24) := '00000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(11386399164088183)
,p_file_name=>'icons/app-icon-144-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_192_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000C0000000C0080600000052DC6C07000009C8494441547801EC9C3F8B1D55188787A091152298550B09410831411B4B3B11ACB4B0B10FFA19046B4BC1CFA0D80B56B1B1900882959DE222692458B9162EB8';
wwv_flow_imp.g_varchar2_table(2) := '240ABABF5DCEDC93CB9D3B6766CE9C39EFBC8F70F69C99397F9FF77DF6DEC47B73E9E36FEEFC478181D71CB8D4F01F041C134000C7C1E7E84D830064816B0208E03AFC1CDEB100041F02BC0522079C13E015C07902783F3E0278CF00E7E74700E709E0FD';
wwv_flow_imp.g_varchar2_table(3) := 'F808E0310338734B00015A14343C1240008F51E7CC2D01046851D0F04800013C469D33B70410A04541C30381ED3322C03611AE5D11400057E1E6B0DB0410609B08D7AE082080AB7073D86D0208B04D846B57041C09E02AAE1C369100022482A2DB3A0920';
wwv_flow_imp.g_varchar2_table(4) := 'C03AE3CAA9120920402228BAAD930002AC33AE9C2A910002248232DD8DCD771240804E343CF04000013C449933761240804E343CF04000013C449933761240804E343C580381BE3320401F219EAF9A0002AC3ABC1CAE8F0002F411E2F9AA0920C0AAC3CB';
wwv_flow_imp.g_varchar2_table(5) := 'E1FA0820401F219EAF9AC08A055875DC385C260208900924D3D824800036E3C6AE331140804C2099C6260104B01937769D890002640259D5346C2699000224A3A2E31A0920C01AA3CA9992092040322A3AAE910002AC31AA9C2999000224A3A2A3050243';
wwv_flow_imp.g_varchar2_table(6) := 'F7E85A8047A7FF34C70FFE6A7EFFF5D864D1DE4F8EFF6E748EA181A7FF0501B7022879FE384BFE8767125CA0B0F7537B3FF9F3B4D1392482BD132CBF6397022859943CCBE3CFB70389A073E59BD1C74CEE04509228594278DF7EFDBDE6933B9F9B2961DF';
wwv_flow_imp.g_varchar2_table(7) := 'AA6FDF78A551515B45E7D2F9D4A6A4117027C0A3D37F5B324AFE376EBDD35E5B6BDCB876AB514182F1915B910069101E46EFF92D277F7C5A2488690C6BBB1360181E3BBD91605CAC10601CB72A4721C1F0B020C07066558F408261E1418061BC4CF44682';
wwv_flow_imp.g_varchar2_table(8) := 'F43021403AAB7A7BEED81912EC80B2E31602EC80B2965B48D01F4904E86764BA0712EC0F1F02ECE7B38AA748D01D4604E866B3AA2748B03B9C08B09BCB2AEFAE5182A9814280A9048D8D4782C70386008FF3707185049B3023C08685ABD62E093C7EB30C';
wwv_flow_imp.g_varchar2_table(9) := '018CA5FDADEBAFB63BBEFFE0A86D8F694882E7AFBED00E3D393E6DDB5E1A08602CD26FBDF66EBBE35FEEFFDC4C95E0E5976EB7F3796C1816C063B89AE6FAB3379BF8554012DCBDF75533B67CFFE3772DC8F8BB12EDCD953710C060803F78F3C346DF6633';
wwv_flow_imp.g_varchar2_table(10) := 'B8F5EAB68C00D585246D43FA369B24885F0DD246D22B268000310D636D49A05783A95FEA3776ECACDB4580AC3899CC1A0104B01631ED97928D00026443C94416092080C5A8B1E76C0410201B4A26B24800012C468D3D67238000D95032510902B9D74080';
wwv_flow_imp.g_varchar2_table(11) := 'DC4499CF14010458205CF78EEE361F7DF17EA37A81E55932228000118C124D25FDD73F7C79BE54A8CF2FF8B108010428883D4E7E2DABCFF2A8A62C4700010AB1DF95FCFA2C4FD7F2EAAFB749538AE6E89A9FFB17040C0970B1618B3F9588F1DB1DFDE6DF';
wwv_flow_imp.g_varchar2_table(12) := '97FC3A63DC5FD7634A8E39C6AC6B690C02CC1CAD31C9AF2D4912D5534A8E39A6AC6F612C02CC18A5B1C9AF2DE91562EAC79C3587E6A2741340806E36939E4C49FE490B337810010418842BAD33C99FC6A9865E08D0130525B3FE2646754FD7F3C7EA17FF';
wwv_flow_imp.g_varchar2_table(13) := 'E153EFC327BF15399F991F731040801EAA2199552BB9F775D773F50B7D48FE40A2DE1A017A62A3240E5D94DC4AF2701DD7BAAFE7E19EC6F19B3FD0A8B746809ED8288995CCA19B925CC91EAE55EB5AF7D556517F8D537B6CD19C7AEB35A5688EB1EB7B19';
wwv_flow_imp.g_varchar2_table(14) := '8700099156322BA94357257B482ED5BA0ECFD44FFDC3F5D83A9E73C939C6AE6D651C0224464A49ADE40EDD95A09F7DFB69A33ADCD373F50BD7536ACD3565BCC6E69843F32C59E65E1B0106105672C74975F4DB4FED68DDD7F3F6C6C486E6E27F844D8498';
wwv_flow_imp.g_varchar2_table(15) := '301C011220C55D94984AF6F89EAE753FBE47DB06010418112725BB925E4355EB5A6D8A3D02083032664A7ABD45513D720A86554000012A08025B588E40C5022C078595FD1040003FB1E6A43B0820C00E28DCF2430001FCC49A93EE2080003BA070CB0F01';
wwv_flow_imp.g_varchar2_table(16) := '04A831D6ECA918010428869A856A2480003546853D15238000C550B3508D0410A0C6A8B0A7620410A018EACD42FA128DBEE9A57A73979608942E085098B8923E7C8926D485B7C0721101048860CCDD8C935F6BE9A3D4AA29CB11408042EC7725FFBE8F52';
wwv_flow_imp.g_varchar2_table(17) := 'ABBFDE264D299AA3D0F1CC2E83000542A7448CDFEEE837FFBEE4D796E2FEBA1E5372CC31665D4B631060E6688D497E6D4992A89E5272CC31657D0B632B12C002AE617B1C9BFC5A45AF10FAC6D994A2393417A59B000274B399F4644AF24F5A98C1830820';
wwv_flow_imp.g_varchar2_table(18) := 'C0205C699D49FE344E35F442809E282899F53731AA7BBA9E3F56BFF80F9F7A1FCE5B91733455FE40809EB0846456ADE4DED75DCFD52FF421F903897A6B04E8898D92387451722BC9C3755CEBBE9E877B1A97FC9B3F0CA22E4E00017A902B8995CCA19B92';
wwv_flow_imp.g_varchar2_table(19) := '5CC91EAE55EB5AF7D556517F8D537B6CD19C7AEB35A5688EB1EB7B198700099156322BA94357257B482ED5BA0ECFD44FFDC3F5D83A9E73C939C6AE6D651C0224464A49ADE40EDD95A0FCEBD08186DD1A0106C46E5B02FE75E801F02AED8A000303B32D81';
wwv_flow_imp.g_varchar2_table(20) := '86EB9541F7D5A60C23B0746F0418110125BB925E4355EB5A6D8A3D02083032664A7A7D4E47F5C8291856010104A820086C61390208B01C7B56AE800002541004B6B01C81050558EED0AC0C8140000102096A970410C065D839742080008104B54B0208E0';
wwv_flow_imp.g_varchar2_table(21) := '32EC1C3A10408040A264CD5AD5107027C053074FB6F0F551E6F6C269236610B3F182C39D00570E0FDAD8EA23CD7102B40F9C3474763108C7BD7CF04468BAA9DD0970F9EC1520FE4DA70498F2AD2BCB6375F690E957AE1E34570E9F0E976E6A770228B287';
wwv_flow_imp.g_varchar2_table(22) := 'D79E691470B5294DA35F081E935FB17729800EAE804B02055FD71E8BCEFEDCD92F03FD422875FEDAD6712B8002210914FC176F1E361E8BCEAEB78462E1B5B816C06BD039F78600026C58D0724800011C069D236F0820C086052D87040A0AE0902E47AE9E';
wwv_flow_imp.g_varchar2_table(23) := '0002541F22363827010498932E73574F0001AA0F111B9C930002CC4997B9AB2780002542C41AD51240806A43C3C64A104080129459A35A0208506D68D8580902085082326B544B0001AA0DCD3A3656FB2910A0F608B1BF590920C0AC7899BC760208507B';
wwv_flow_imp.g_varchar2_table(24) := '84D8DFAC04106056BC4C5E3B0104A83D42EC6F5602330A30EBBE991C0259082040168C4C62950002588D1CFBCE420001B2606412AB0410C06AE4D8771602089005E3D6245C9A2180006642C546E72080007350654E330410C04CA8D8E81C0410600EAACC';
wwv_flow_imp.g_varchar2_table(25) := '698600029809958D8D5ADB2502588B18FBCD4A0001B2E264326B0410C05AC4D86F5602089015279359238000D622C67EB312C82840D67D3119048A104080229859A4560208506B64D8571102085004338BD44A00016A8D0CFB2A4200017260660EB30410';
wwv_flow_imp.g_varchar2_table(26) := 'C06CE8D8780E020890832273982580006643C7C6731040801C1499C32C0104301BBA3A366E7D17FF030000FFFFA648FD7900000006494441540300CCEE335B21572A360000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(11386607039088183)
,p_file_name=>'icons/app-icon-192.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_256_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A86600001000494441547801EC9DCBAB645715C6F70D6848208269CD404250421EE83F9059BA073D89E028F3EE38752A080EACDB0E848053A7A67B2E08429CF4A0D303419C';
wwv_flow_imp.g_varchar2_table(2) := '8A924E084A080EA21DC140420C58D6577577DF53E79E7ADC73F663EDB37E45AF7B5E75F65EEBB7F6FACEA3AA4E3F16784100026E0920006E534FE010080101601440C0310104C071F209DD3701458F0088020601A7041000A789276C08880002200A1804';
wwv_flow_imp.g_varchar2_table(3) := '9C1240009C269EB07D1388D123009104530838248000384C3A2143201240002209A6107048000170987442F64DA01B3D02D0A5C13C049C1140009C259C7021D02580007469300F01670410006709275CDF04FAD123007D222C43C0110104C051B2091502';
wwv_flow_imp.g_varchar2_table(4) := '7D0208409F08CB107044000170946C42F54D60287A0460880AEB20E0840002E024D1840981210208C01015D641C0090104C049A209D337815DD12300BBC8B01E020E0820003B927C7AF7E6D521BB75F7E6296697C150CEB46E479ADDAF762B001A143215';
wwv_flow_imp.g_varchar2_table(5) := 'F3CFEFDEB817EDD6DD1B4BD94958DE1BB210968B802D8251064339D33AE534DA79AE3742A671E05509DC0880927C9EF81B4B0D0A9906F23284ABD1BC0E044F719FE77A23E61A0712078D0F1D106473E2B12F96D90A800A5E89DC247553F0E789DF87846D';
wwv_flow_imp.g_varchar2_table(6) := '5E09687C84B3339BAE20682CCD95C9EC0440C952D14BD595CC4D52E79A3EE2CA49603376960B8D2509820E2839FBABD1F62C042016BD92A4646D125703277DCE9BC072A131262190CD21D6A60520163E453F87A1D8520CCB45585D2A480464963D3FE45B';
wwv_flow_imp.g_varchar2_table(7) := '930240E11F4A2BDBCB1038178232FDA5EFA5390190E272C44F3F1068710A81F34B8329ADD4D8B7190188477D9D7AD500459F10384C404270F3F4F0FBECBCA30901E0A86F67C0E0C9210212017D99ACBE101CF254DBCD0B808A9FA3BE5285B5454042605F';
wwv_flow_imp.g_varchar2_table(8) := '044C0B00C5DFD690C7DB3E01FB2260560028FEFE6062B94D02B645C0A40050FC6D0E75BCDE45A0BC08ECF2A4BFDE9C0050FCFD14B13C0F023645C0940050FCF318EA44B18B803D11302500DCEDDF3570583F1F02CB85BED362251E3302B039FA5BC1821F';
wwv_flow_imp.g_varchar2_table(9) := '10C847E0B1A0AF10E76BFF322D9B10804DF1DB81721980BC17029725A05FAB6EC6FC65F74CFF7E1302C0A97FFAC4D2A27502362E05AA0B801525B43E5CF06F7E042C5C0A5415804DF173EA3FBFA14D44C710D0A540EA1B82C7F4DB7D4F5501E83AC23C04';
wwv_flow_imp.g_varchar2_table(10) := '3C12A87D16504D0038FA7B1CEEC4DC2750FB2CA09A00F441B00C01AF046A9E05541400AEFDBD0E78E2DE26A0B380ED35E396C6EC55450036A7FF63DC651F08CC9340AD9B81550480CFFDE73988896A3C815A9701C505A096D28D4F0D7B42203F015D06D4';
wwv_flow_imp.g_varchar2_table(11) := 'A88DE2027012C2D5C00B0210B840604A6D5C68ECC815150460F9EA91BEF13608B8227012CAD7467101D0A98EABAC122C048E2450A3368A0A0077FF8F1C09BCCD2D81D2F7018A0A80DBAC1238048E2430E6D380239B1E7C5B5101A8718D3318352B210081';
wwv_flow_imp.g_varchar2_table(12) := '3581A20250E31A671D257F20D00881D235524C004A5FDB34926FDC84C00502256BA59800D4F88CF302595640606604A686534C00A63ACAFE10F042A0E4C1B298007003D0CBF025CEA9044AD64A3101980A85FD210081F4048A0940E9BB9BE951D122046C';
wwv_flow_imp.g_varchar2_table(13) := '1148E14D310148E12C6D40C0038192074B04C0C388224608EC205044004A7EAEB9234E5643A02902A56AA6880034451E6721D00081542E2200A948D20E041A2480003498345C86402A0208402A92B40381060920000D260D977D1348197D110128F9DDE6';
wwv_flow_imp.g_varchar2_table(14) := '947072B7F5DFCFBF0CAD5B6E465EDB2F55334504C06B1277C5FDF0A3FF847FBCFF30FC6B356DDD1487E2F9F4E167BBC265BD61020840C1E4E868AF82F96275E42FD86DF6AE14CFA79F7C1E1081ECA8937780002447BABB411DED776F6D7F8B44406703ED';
wwv_flow_imp.g_varchar2_table(15) := '47623782D49E2100A989EE68AF7F747CED95D7C39B37DE6ACE7EF4839F6E45F8F2F3DF0DB2B85267038840A4617F8A0014CA918E8EB12B15FFAB2F7D3F2E363D7DFED997820C1168338D084081BCE9DABFDBCD5C8ABF1B1322D0A5D1CE3C025020575F7C';
wwv_flow_imp.g_varchar2_table(16) := 'F6E5A35E5E7AEE7B8FE6E7368308E4CD688ED611801C541DB78908B4957C04A0AD7C35E12D22D0449AD64E22006B0CFC494D0011484D344F7B08401EAEB4BA228008AC2024FA97AB1904201759DA5D134004D618CCFE4100CCA6663E8E210276738900D8';
wwv_flow_imp.g_varchar2_table(17) := 'CDCDAC3C43046CA61301B09997597A85088C4B6BCEBD10809C7469FB020144E00292AA2B1080AAF87D768E08D8C93B02602717AE3C41046CA41B01B09107975E200287D39EFB1D08406EC2B4BF97C09008F49F9DB0B701364E2280004CC2E76FE7E7BEFE';
wwv_flow_imp.g_varchar2_table(18) := 'C256D01F7CF4606B79CC8244E09B4F3FF368D7EEB3131EAD64260B0104200BD67937DAFD49F3BB1FFC35A4108117BFFDF216B4FE3314B636B2908C0002900CA59F867E78EDC75BC14A04DEBEFFDBF0A73FFF61B4BDF7F777B7DA642184120C1080129467';
wwv_flow_imp.g_varchar2_table(19) := 'D847FFD9800AF19F9F7C1CA698DA88D67D884A5CC7343D0104203D53172DEA5E801E6AAAE71BBA0878A6412200334D6CA9B0F47C430981CE08240653AC7B6FA194FFDEFB4100BC8F8044F1EB8C406230C512B9328B664A05810094224D3F103048000130';
wwv_flow_imp.g_varchar2_table(20) := '98145C82402902084029D2F40301830410008349C125DF044A468F0094A44D5F1030460001309610DC81404902084049DAF40501630410006309C11DDF044A478F0094266EA0BF5FDFFB65F8C99D37C2FD076F1BF006176A1240006AD2AFD0B78AFFC187';
wwv_flow_imp.g_varchar2_table(21) := '7F59F7FCFB3FFE663DE58F5F020880A3DC778B5F61EB7BFB9A627E0920004E72DF2F7EFDF046DFDBDF17BEF6996A5C66EC23BCBDADC6120250837AE13E55C4F1B45F5DABF8FB0FF5D0FAAEA970B5CF54D365C687FF7EBFDB34F386082000869291C39531';
wwv_flow_imp.g_varchar2_table(22) := 'C52F3FBEF3CC8B9A24B1BF7DFC5E927668243D0104203D53332D8E2D7E05A09FF7A6F88DBFDA3874A9A1FEB03A0410803ADCB3F73AA5F8A373120115EF14531BB13DA6BB09D4DA8200D4229FB1DF14C59FD13D9A3644000130948CBE2BBA7926EBAFDFB7';
wwv_flow_imp.g_varchar2_table(23) := '4CF1EFA3C3B63E0104A04FC4C8B2EEC2FFEA77BF0832CD1FE316C57F0C25DED32580007469189AEFDE85D74769874480E23794BC4BBA52F3ED08404DFA7BFAD6CD337D5E1FDFB24F047216BF2E41A658F49FA94D020880CDBCACBDD297750E8940AEE2D7';
wwv_flow_imp.g_varchar2_table(24) := '19877E30A44B9029A6362420EB80F8638E0002602E25DB0EED13815CC5BFEDC1F425BE08349D61AE1610805C6413B63B2402B98B5FF720BA671F63C3511BFA1EC1D8FDE7BE5FEDF81080DA1938B2FFBE08E83BFA71571599B6C7E51453DD83509BFA5F7F';
wwv_flow_imp.g_varchar2_table(25) := 'A698DA48E10F6DE4218000E4E19AA55515938ABDDBB896B5BEBB8E79081C4B000138969491F7A9D855F47247532D6B1E83C0180208C0186A95F751D1EB47369A567685EE2710B0B02B0260210B237CD035FA88DDD805025B0410802D1C2C40C0170104C0';
wwv_flow_imp.g_varchar2_table(26) := '57BE8916025B0410802D1C2C40A00C012BBD20005632811F10A8400001A8009D2E2160850002602513F801810A0410800AD0E9D237014BD1230096B2812F10284C0001280C9CEE206089000260291BF80281C2041080C2C0E9CE37016BD12300D63252C0';
wwv_flow_imp.g_varchar2_table(27) := '1F3D4C448FEAD263BF0A74471786092000869393C335157F7C98881E349AA30FDA6C870002D04EAE267BDA2D7E35F6DA2BAF6B823926800038497EBFF8F5309143CFEAD33E538DCB8CF30166710E01B09895C43EA988E369BF9A56F11F7A98880A57FB4C';
wwv_flow_imp.g_varchar2_table(28) := '355D66F0587051B7690880CDBC24F36A4CF1AB733D1558D314C663C15350CCD306029087AB8956C716BF9CD71387F4D831DD2798626AE3D0A586FAC3EA104000EA70CFDEEB94E28FCE490454BC534C6DC4F63C4FADC68E0058CDCC04BF5214FF84EED9B5';
wwv_flow_imp.g_varchar2_table(29) := '21020880E164E9E699EC322E52FC97A1C57B1100A3634077E1E37FCAA9F963DCA4F88FA1C47BBA0410802E0D43F3DDBBF0FA28ED900850FC8692D773C5F2220260343BBA79A6CFEBA37BFB442067F1EB12648A45FF99DA248000D8CCCBDA2B7D59E79008';
wwv_flow_imp.g_varchar2_table(30) := 'E42A7E9D71E80743F13264EC546D4840D601F1C71C0104C05C4AB61DDA2702B98A7FDB83E94B7C11683AC35C2D2000B9C8266C7748047217BFEE4174CF3EC686A336F43D82B1FBB7BE9F75FF1100EB193AF3AF2F02FA8EFED9A6A022D3F6B89C62AA7B10';
wwv_flow_imp.g_varchar2_table(31) := '6AF3CD1B6F8529A63652F8431B7908200079B8666955C5A462EF36AE65ADEFAE631E02C71240008E2565E47D2A7615BDDCD154CB9AC7203086000230865AE57D54F4FA918DA6955DA1FB3D045AD88400B490A5011F758D3EB09A5510B8140104E052B878';
wwv_flow_imp.g_varchar2_table(32) := '3304E645000198573E890602972280005C0A176F86C071045A791702D04AA6F013021908200019A0D224045A218000B49229FC84400602084006A834E99B404BD123002D650B5F21909800029018E850738F3FF99547ABBB3FE279B4929935812E9B2EB3';
wwv_flow_imp.g_varchar2_table(33) := 'F546FE6421800064C1BADDE8579F3817006DE10119A2B06D7A0049774D9F59771BF3E9082000E958EE6DE9F18E08E8E93AFD01BF77E7996F140B3DF22C86F9D4D34FC4D9E6A6AD398C0014CAD85357B607B506BC1E9785BD11C4A29B86A7AE3CD95D643E';
wwv_flow_imp.g_varchar2_table(34) := '2301042023DC6ED33AA5E5C8D625323CFF8D67BF36BC81B55908200059B00E37AA23DBB75EB81210828B7C7489243612CA8B5B59938B0002908BEC9E76A31068C0EB88E7DDC4E1CA0C8EFC7B526E765311015886F04EE0354840473CEF3608C6F9CA5235';
wwv_flow_imp.g_varchar2_table(35) := '5344009CE792F02160960002603635380681FC041080FC8CE9C10181564344005ACD1C7E43200101042001449A8040AB048A08C0E9F5DB7C0AD0EA08C1EF2A044AD54C1101A842904E21508840CBDD14138013BE0BD0F238C1F7991228260033E5475810';
wwv_flow_imp.g_varchar2_table(36) := '484EA0E4C11201489E3E1A84403B048A09C0329CDC6F070B9E42E0380239DE55B2560A0A40E09380C00B02B6081413005B61E30D04EC125816BC615E4C004A7DAE6937AD780681E30894AC956202A0D04BDEDD547F18047212C8D176E91A292A003980D1';
wwv_flow_imp.g_varchar2_table(37) := '2604E6446059F866795101F85F38B935A764110B045A275054004A5EDBB49E18FCF7496071FDF669C9C88B0A80022B7D8DA33E3108A42690A3BD1AB5515C004A5FE3E448146D422007811AB5514100025F080ABC207091C0B2E0E7FFB1F7E202A0FB0035';
wwv_flow_imp.g_varchar2_table(38) := '4E7562C04C216095806AA3B46FC5054001F269802860AD12C8E3779D4FC8AA08400DA5CB93345A85401A02A5EFFE47AFAB08803AE7324014300888409DA3BF7AAE26005C06083F0681BA04AA09802E03380BA89B7C7ABF3C81F47B9CDCAA75FAAF58AA09';
wwv_flow_imp.g_varchar2_table(39) := '803AE72C40143008D423505500380BA897787AB640A0EED15F04AA0A801CE02C4014308F046A9EFA47DED505406701815F09065EF609A4F5B0DE9DFF6E1CD50540CE4809B9212812980F02F54FFD236713022067B8141005CC03011DF0ACC4694600B814';
wwv_flow_imp.g_varchar2_table(40) := 'B03224F0232F011BA7FE31463302208736CA680B90FCC2209086809D53FF188F2901905388802860F32360AFF8C5D89C00C829444014B0F910B059FCE26B5200E41822200A58FB04EC16BFD89A15003987088802569BC0F8FE6D17BFE2322D0072101110';
wwv_flow_imp.g_varchar2_table(41) := '05AC3D02F68B5F4CCD0B809C94082CAEDF39097C6330F0B24D603548DF5986936B8BC28FF71E4BA5090188C16DA0F23161E4C1D41A81935B3FBB7EE7DAE63B2DD67C1BF6A729015008128105670342811520704C17AD1DF5BB31352700D1F9C5FA144B67';
wwv_flow_imp.g_varchar2_table(42) := '03B2B8962904CA118885DFDA51BF4BA85901501012015958DF1B400802AF2204E650F81154226E0319000001C049444154D302108390086C8C1B859109D3B40462D12F56979F2D1FF1FB54662100DDA016AB4B83C52A49BA131B5667064A5CE005811104';
wwv_flow_imp.g_varchar2_table(43) := '3663E7E496C6D29C8ABE8B6276021083D39DD8C54A0C94B8C54A10C24A0C649BA4065E10B840406343A682D798D98C9DDBA71A4B17DE3C9315B315807E7E162B31906D927AE744490E1D5150E203AFD913509EA38555FE350E648BD54142634336E7820F';
wwv_flow_imp.g_varchar2_table(44) := 'BD971B01E8C51D94E445471494F8C56A1044D3A018B2B01A34986EB8DAB4A19C695DCCABF21C6DB1CABFC6812C387DB9158043F9D6A018320D1AECF6A955064339D3BA43F9EE6FF7B28C0078C9347142608000023000855510F0420001F09269E284C000';
wwv_flow_imp.g_varchar2_table(45) := '010460000AAB7C13F0143D02E029DBC40A811E0104A0078445087822800078CA36B142A0470001E80161D137016FD12300DE324EBC10E81040003A3098858037020880B78C132F043A0410800E0C667D13F0183D02E031EBC40C81330208C019082610F0';
wwv_flow_imp.g_varchar2_table(46) := '480001F098756286C0190104E00C0413DF04BC468F0078CD3C7143604500015841E01F04BC124000BC669EB821B0228000AC20F0CF3701CFD123009EB34FECEE092000EE8700003C1340003C679FD8DD134000DC0F01DF00BC47FF7F000000FFFF62E318';
wwv_flow_imp.g_varchar2_table(47) := '1F0000000649444154030078580CA6E946D5C40000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(11386913844088183)
,p_file_name=>'icons/app-icon-256-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_32_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF400000136494441547801EC93BF6A024110C607D3848414C785846048B884C42E04D24410C4565B7BF1217C001FCACA42C417B05551510451382DC43F60A17C03538AB3';
wwv_flow_imp.g_varchar2_table(2) := 'EB81A07BF0EDEC2E7BFBFD76762756AE1676E7548CCEFC39009701970175069E6FDFE9D7CF1CD436BCA145B8322E6A35C0CBFD07A513B983F2BD478A7B8131841A4073B4CFD784314464007F418ABAA316732E666B8E9A2632809F78928AA9122BFB9FD7';
wwv_flow_imp.g_varchar2_table(3) := '78F39A930086F30E6F724A630D506F55A83F6DB337FA900D9031008C2038A32A10450224634D34068069F0F4CDE528069813C99C361A0360E337EF0B2112590188B3CD9DCBBF12AD01F00EE4CED1876C808C016004E104B877449100C958138D01607A9D';
wwv_flow_imp.g_varchar2_table(4) := '8F70BCEC1152AF51A35DD1649FD7A8AF60B2195033ACA9F4E0DFF1E69A460DA0D9CC668D037019B8FC0C1CAB8C3D000000FFFF90DEB721000000064944415403004D83DF81A07024310000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(11386157246088182)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_512_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000200000002000806000000F478D4FA00001000494441547801ECDD4F8864C77D07F056481C1C5088ACC4866096D8421E61611039090291053A18092C02BA2FAB8B0F3E5A20E35B2E0681AEBE4AE86E0832C8';
wwv_flow_imp.g_varchar2_table(2) := '97088402019F822E8EB31122208C0E8ED74A2CF022CB90EC6F573D9A9DEDEE57AFFBFDA9AADF27B83533FDEA55D5EFF3EB6C7D677666F68FFEF19FAFFE9F0703AF01AF01AF01AF01AF815CAF813FDAF83F0204081020402099C0662300A46BB982091020';
wwv_flow_imp.g_varchar2_table(3) := '40808000E035408000010204D20944C1BE02100A1E04081020402099800090ACE1CA2540800081EC0277EA1700EE38F82F010204081048252000A46AB7620910204020BBC0B67E01602BE12D010204081048242000246AB6520910204020BBC067F50B00';
wwv_flow_imp.g_varchar2_table(4) := '9F59788F0001020408A4111000D2B45AA104081020905DE062FD02C0450DEF1320408000812402024092462B9300010204B20BDC5DBF0070B7878F0810204080400A010120459B154980000102D9052ED72F005C16F1310102040810482020002468B212';
wwv_flow_imp.g_varchar2_table(5) := '0910204020BBC0BDF50B00F79A78860001020408742F200074DF6205122040804076815DF50B00BB543C4780000102043A1710003A6FB0F20810204020BBC0EEFA0580DD2E9E2540800001025D0B08005DB7577104081020905D605FFD02C03E19CF1320';
wwv_flow_imp.g_varchar2_table(6) := '408000818E0504808E9BAB3402040810C82EB0BF7E0160BF8D2B0408102040A05B0101A0DBD62A8C00010204B20B1CAA5F0038A4E31A0102040810E8544000E8B4B1CA2240800081EC0287EB17000EFBB84A8000010204BA141000BA6CABA20810204020';
wwv_flow_imp.g_varchar2_table(7) := 'BBC050FD02C09090EB0408102040A0430101A0C3A62A8900010204B20B0CD72F000C1B19418000010204BA131000BA6BA9820810204020BB4049FD02408992310408102040A0330101A0B3862A8700010204B20B94D52F00943919458000010204BA1210';
wwv_flow_imp.g_varchar2_table(8) := '00BA6AA7620810204020BB4069FD0240A994710408102040A0230101A0A3662A8500010204B20B94D72F00945B19498000010204BA111000BA69A5420810204020BBC098FA0580315AC61220408000814E0404804E1AA90C02040810C82E30AE7E01609C';
wwv_flow_imp.g_varchar2_table(9) := '97D10408102040A00B0101A08B362A8200010204B20B8CAD5F00182B663C0102040810E8404000E8A0894A2040800081EC02E3EB1700C69BB9830001020408342F200034DF42051020408040768163EA17008E51730F0102040810685C400068BC81B64F';
wwv_flow_imp.g_varchar2_table(10) := '80000102D9058EAB5F0038CECD5D0408102040A0690101A0E9F6D93C01020408641738B67E01E05839F711204080008186050480869B67EB04081020905DE0F8FA0580E3EDDC4980000102049A1510009A6D9D8D1320408040768153EA17004ED1732F01';
wwv_flow_imp.g_varchar2_table(11) := '020408106854400068B471B64D80000102D9054EAB5F0038CDCFDD0408102040A0490101A0C9B6D93401020408641738B57E01E05441F713204080008106050480069B66CB04081020905DE0F4FA0580D30DCD4080000102049A1310009A6B990D132040';
wwv_flow_imp.g_varchar2_table(12) := '8040768129EA1700A65034070102040810684C400068AC61B64B80000102D905A6A95F0098C6D12C0408102040A0290101A0A976D92C01020408641798AA7E01602A49F310204080008186040480869A65AB04081020905D60BAFA0580E92CCD44800001';
wwv_flow_imp.g_varchar2_table(13) := '02049A1110009A69958D1220408040768129EB1700A6D4341701020408106844400068A451B64980000102D905A6AD5F0098D6D36C0408102040A0090101A08936D92401020408641798BA7E01606A51F311204080008106040480069A648B0408102090';
wwv_flow_imp.g_varchar2_table(14) := '5D60FAFA0580E94DCD488000010204AA171000AA6F910D1220408040768139EA1700E65035270102040810A85C4000A8BC41B64780000102D905E6A95F0098C7D5AC0408102040A06A0101A0EAF6D81C01020408641798AB7E01602E59F3122040800081';
wwv_flow_imp.g_varchar2_table(15) := '8A0504808A9B636B04081020905D60BEFA0580F96CCD4C8000010204AA151000AA6D8D8D1120408040768139EB1700E6D435370102040810A8544000A8B431B64580000102D905E6AD5F0098D7D7EC0408102040A04A0101A0CAB6D81401020408641798';
wwv_flow_imp.g_varchar2_table(16) := 'BB7E01606E61F31320408000810A0504800A9B624B04081020905D60FEFA0580F98DAD408000010204AA131000AA6B890D1120408040768125EA17009650B6060102040810A84C4000A8AC21B64380000102D90596A95F0058C6D92A0408102040A02A01';
wwv_flow_imp.g_varchar2_table(17) := '01A0AA76D80C01020408641758AA7E01602969EB1020408000818A0404808A9A612B04081020905D60B9FA0580E5ACAD448000010204AA111000AA69858D1020408040768125EB170096D4B6160102040810A8444000A8A411B64180000102D90596AD5F';
wwv_flow_imp.g_varchar2_table(18) := '0058D6DB6A0408102040A00A0101A08A36D80401020408641758BA7E01606971EB1120408000810A0404800A9A600B04081020905D60F9FA0580E5CDAD48800001020456171000566F810D1020408040768135EA1700D650B72601020408105859400058';
wwv_flow_imp.g_varchar2_table(19) := 'B901962740800081EC02EBD42F00ACE36E550204081020B0AA8000B02ABFC50910204020BBC05AF50B006BC95B970001020408AC282000AC886F6902040810C82EB05EFD02C07AF656264080000102AB090800ABD15B9800010204B20BAC59BF00B0A6BE';
wwv_flow_imp.g_varchar2_table(20) := 'B50910204080C04A0202C04AF0962540800081EC02EBD62F00ACEB6F750204081020B08A8000B00ABB450910204020BBC0DAF50B006B77C0FAC502BFBFF9C9E6C62F7F7BFEF8E0DD1B1B8FBE0DB6FDFEE8C6EF36F1287EB1184880C0A08000304864C0DA';
wwv_flow_imp.g_varchar2_table(21) := '02F1077F1CF4BFBE75F87F7C2B046C1F6BEFCBFAF30B6C7BFDD16F6E6EE211AF83783DCCBFB21508CC2DB0FEFC02C0FA3DB0833D02F107FDED3FF06FFDE1BF6788A7130A0802099BAEE45904048059584D7AAA407CE937FEA03F751EF7F72B10AF8F789D';
wwv_flow_imp.g_varchar2_table(22) := 'F45BA1CA7A16A8A13601A0862ED8C3B9C0F6EFF9E34BBFE74F7A87C01E81789DC45789E275B36788A70910D8232000EC81F1F43A02DBBFE75F6775ABB62A10AF1B21A0D5EE65DC771D350B0075F4C12E6E09F872EE2D04FF3B5A4008389ACE8D49050480';
wwv_flow_imp.g_varchar2_table(23) := 'A48DAFADECF886BFF8726E6DFBB29FB6048480B6FA9575B7B5D42D00D4D289E4FB886FE82A2138BBF2E8E6E9C79FDB7CF7DB3FD8BC74F5558FC60D867AFEC8435FDFC46368DCC5EB42C0450DEF13D82F2000ECB771652181F8ECBF64A938F89F7FF285CD';
wwv_flow_imp.g_varchar2_table(24) := '1367CF6CAE3CF070C92DC6342EF0D097CF36F178E6897F1815048480C61BDFF5F6EB294E00A8A717697752F2D97F1CFE71F0A74552F8ED2030E6AB014280170D81C30202C0611F57671628F9ECDFE13F73131A9A3EBE1AF0777FFBF7C53B16028AA90C5C';
wwv_flow_imp.g_varchar2_table(25) := '48A0A66504809ABA612F3B057CE6BF9325ED937F71FF831B21206DFB153EA180003021A6A9C60BFCFEE61F0EDE149FFD1F1CE0624A01212065DB3B28BAAE120480BAFA61379704BEF2C5AF5D7AC68704EE080801771CFC97C0B10202C0B172EE9B44E0E3';
wwv_flow_imp.g_varchar2_table(26) := '9B9F1C9CC777FB1FE4497F510848FF12680AA0B6CD0A00B575C47E0810182520048CE23298C0B98000704EE11D02045A1510025AED5CA67DD757AB00505F4FEC8800812304848023D0DC925A400048DD7EC513E84B4008E8AB9F3D5553632D02408D5DB1';
wwv_flow_imp.g_varchar2_table(27) := '2702048E1610028EA673633201012059C3954B2083801090A1CB2DD558E75E05803AFB625704089C2820049C08E8F6EE050480EE5BAC400279058480BCBDAFA9F25AF72200D4DA19FB224060120121601246937428200074D85425112070B7801070B787';
wwv_flow_imp.g_varchar2_table(28) := '8F9614A8772D01A0DEDED8190102130A080113629AAA0B0101A08B362A820081120121A044C99829056A9E4B00A8B93BF64680C0E40242C0E4A4266C54400068B471B64D80C0F10242C0F176EE1C2350F75801A0EEFED81D01023309080133C19AB61901';
wwv_flow_imp.g_varchar2_table(29) := '01A09956D9280102530B0801538B9AEFA240EDEF0B00B577C8FE0810985540089895D7E4150B08001537C7D608105846400858C639D72AF5572B00D4DF233B2440600101216001644B5425200054D50E9B2140604D0121604DFDBED66EA11A01A0852ED9';
wwv_flow_imp.g_varchar2_table(30) := '2301028B0908018B515B6865010160E506589E0081FA048480FA7AD2D68EDAD8AD00D0469FEC9200818505848085C12DB7B88000B038B90509106845400868A55375EDB395DD0800AD74CA3E0910584540085885DDA20B0808000B205B820081B6058480';
wwv_flow_imp.g_varchar2_table(31) := 'B6FBB7ECEEDB594D0068A757764A80C08A0242C08AF8969E4540009885D5A40408F4282004F4D8D5696B6A693601A0A56ED92B0102AB0B0801ABB7C006261210002682340D0102790484803CBD1E57695BA30580B6FA65B704085422704C08A864EBB641';
wwv_flow_imp.g_varchar2_table(32) := 'E0B68000709BC17F081020305E606C08B8F1CBDF8E5FC41DCD08B4B65101A0B58ED92F010255098C09011FDFFC64F3D18DDF55B57F9BC92B2000E4EDBDCA09AC2E7076E5D1837BF89F8F6E1CBC5ECBC53121E0A3DFDCAC65DBF631A9407B930900EDF5CC';
wwv_flow_imp.g_varchar2_table(33) := '8E09A411B8F1BFBF6EA6D63121C05F0534D3D6AE372A0074DD5EC511685BE0C687ED0480902E0D01F1570131DEA31F81162B11005AEC9A3D13E844E0A9C79E3D58C97FFFE6579BF77E79FDE098DA2E460878E4A1AF0F6EEBF7373F191C63008139050480';
wwv_flow_imp.g_varchar2_table(34) := '3975CD4D80C041812B0F3C7CF07A5CFC8FF7FEBDB910F0D097CF367FF5852FC6F6F73E3EBAE17B01F6E23477A1CD0D0B006DF6CDAE097423F0F4E3CF0DD6D26208182CCA00022B0B08002B37C0F204B20B3C71F64C1141848037DEFEA7DB5F0D68E1A703';
wwv_flow_imp.g_varchar2_table(35) := 'BEF6378F14D56550FB02AD562000B4DA39FB26D09140C95701B6E54610F8D77FFB974D84819A1FB1C7ED9E77BDF58D80BB543CB7A48000B0A4B6B50810D829105F0518FA9D003B6FF42481D505DADD8000D06EEFEC9C405702CF3FF9C24608E8AAA58AA9';
wwv_flow_imp.g_varchar2_table(36) := '5C4000A8BC41B6472093C0D08F0566B2506B1B022DEF520068B97BF64EA03381F8B1C097AEBEEA2B019DF55539750A080075F6C5AE08A41688BF0E18F38D81A9B114BFA240DB4B0B006DF7CFEE09742B10DF18185F0D1004BA6DB1C256161000566E80E5';
wwv_flow_imp.g_varchar2_table(37) := '0910382C7031084418886F148CC7E1BB5C2530BF40EB2B0800AD77D0FE0924118820108FF8EB8178C457076A7F24698D321B1510001A6D9C6D13204080C09A02EDAF2D00B4DF4315102040800081D10202C0683237102040804076811EEA17007AE8A21A';
wwv_flow_imp.g_varchar2_table(38) := '0810204080C0480101602498E104081020905DA08FFA05803EFAA80A0204081020304A400018C56530010204086417E8A57E01A0974EAA8300010204088C1010004660194A80000102D905FAA95F00E8A7972A214080000102C502024031958104081020';
wwv_flow_imp.g_varchar2_table(39) := '905DA0A7FA05809EBAA9160204081020502820001442194680000102D905FAAA5F00E8AB9FAA2140800001024502024011934104081020905DA0B7FA0580DE3AAA1E0204081020502020001420194280000102D905FAAB5F00E8AFA72A22408000010283';
wwv_flow_imp.g_varchar2_table(40) := '0202C020910104081020905DA0C7FA05801EBBAA260204081020302020000C00B94C80000102D905FAAC5F00E8B3AFAA22408000010207050480833C2E122040804076815EEB17007AEDACBA087C2AF0FE87EF6E5E79EBE5F3C7DBD7DFF8F48A37040864';
wwv_flow_imp.g_varchar2_table(41) := '16100032775FEDDD0BC4E1FFA39FFC7073FDFD9F9F3F7EFAB31F6F5E7CED5AF7B52B90C03402FDCE2200F4DB5B952517D81EFEFB18E2AB02FBAE799E0081FE050480FE7BACC2840243877F42122513384AA0E79B04809EBBABB69402A587FF271FFF21A5';
wwv_flow_imp.g_varchar2_table(42) := '8FA20910B8232000DC71F05F025D08941EFE51EC235FF946BCF1204060AF40DF170480BEFB58884F400000100049444154ABBA4402630EFF6079E2EC9978E34180405201012069E395DD97C0D8C3FFBBDFFE415F00AA21308340EF530A00BD77587DDD0B';
wwv_flow_imp.g_varchar2_table(43) := '1C73F85F79E0E1C95C62FDF88982F8D1C2161E7E0FC264AD3751E3020240E30DB4FDDC0271F8C6CFF9972AC467FE531EFEB16EAC1FBF6720DE6FE1B1FD3D0861D7C27EED712D81FED71500FAEFB10A3B1588032C0EDFD2F2E638FC5BFE6CFACD775E2FA5';
wwv_flow_imp.g_varchar2_table(44) := '338E4097020240976D5554EF02351CFE611C9F4DC7DB161F2D7DD5A245DFD6F79C61FF0240862EABB12B815A0EFFAE50154320A1800090B0E94A6E57A0B6C3FFECCAA3CD623EFDF873CDEEDDC6E716C831BF0090A3CFAAEC40A0B6C33F489F7AECD978D3';
wwv_flow_imp.g_varchar2_table(45) := 'E4C3EF4168B26D363DA180003021A6A908CC2550E3E11FB5C64F14BC74F5D54D4B9F4DC7572DE21B2263FF1E04760964794E00C8D26975362B50EBE17F11343E9B8E20D0C2E3F9275FD84470B9B87FEF13C828200064ECBA9A9B1168E1F06F06D3460914';
wwv_flow_imp.g_varchar2_table(46) := '09E4192400E4E9B54A1B1370F837D630DB25D0988000D058C36C378780C33F479F55599F40A61D090099BAADD626041CFE4DB4C92609342F200034DF4205F424E0F0EFA99B6A694F20D78E05805CFD566DC5020EFF8A9B636B043A1410003A6CAA92DA13';
wwv_flow_imp.g_varchar2_table(47) := '70F8B7D7333BEE4F205B450240B68EAB77A7C02B6FBDBC89C78BAF5DDB2CFD2FDC39FC77B6C4930408CC2C2000CC0C6CFAFA05E2D08F7F192E1EB1DBF817EEE2B93898E3E3391FB1C6DAFFA4EF9CF5999B403B02F9762A00E4EBB98A2F081CFA6C3F0EE6';
wwv_flow_imp.g_varchar2_table(48) := '38A02F0C9FF4DD983BD6289D347E7DADDF6057AA651C0102430202C09090EB5D0BBCF7C12F0ED61707741CD407071D7131E68CB94B6F75F8974A1947E038818C77090019BBAEE651027150C7813DEAA6038363AE98F3C090BB2E39FCEFE2F00101021309';
wwv_flow_imp.g_varchar2_table(49) := '080013419AA66F8138B0E3E03EB5CA9823E62A9DC7E15F2A651C81530472DE2B00E4ECBBAA3F15B8F6CDEF7DFADEF09B38B8E3001F1EB97B44DC1B73ECBE7AEFB30EFF7B4D3C4380C0740202C07496666A50E0BEFBEEDBC4415BBAF538C0E3202F1DBF1D';
wwv_flow_imp.g_varchar2_table(50) := '17F7C4BDDB8F87DEC69E7CC3DF9092EB04A611C83A8B0090B5F3EA3E178883360EDCF32706DE89833C0EF48161E797636CDC73FEC4C03BB197D8D3C0B06A2E477DDBDFA1103F3E59FBE3D04F7E54836A2304161010001640B644FD0271E0C6C15BBAD338';
wwv_flow_imp.g_varchar2_table(51) := 'D0E3E01B1A1F6362ECD0B8EDF5D843EC65FB710B6FA3BEEDEF506861BF4BFE9E87163CEC31AF800090B7F72ABF2410076F1CC0979EDEFB611C7C71C0EF1B10D762CCBEEB979F8FB5630F979FAFF9E3963F9B7EF39DD76BA6B53702B30B0800B3135BA025';
wwv_flow_imp.g_varchar2_table(52) := '813880E3202EDD731CF071D05F1E1FCFC5B5CBCFEFFB38D68CB5F75DAFF5F9F86CBAD6BD0DEDABA5AF5A0CD5E2FAF10299EF140032775FED3B05E2208E0379E7C51D4FC6411F07FEF652BC1FCF6D3F1E7A1B6BC59A43E35C274080C0940202C0949AE6EA';
wwv_flow_imp.g_varchar2_table(53) := '46200EE438984B0B8A033F0EFE78C4FBA5F7C51AB156E9F8DAC69D5D79B4B62D15EFE7E9C79F2B1E6B60AF02B9EB120072F75FF50704E2608E03FAC090BB2EC5C11F8FBB9E3CF041CC1D6B1C1852FDA5A71E7BB6FA3DEEDBE01367CFECBBE47902290404';
wwv_flow_imp.g_varchar2_table(54) := '80146D56E4B1027140C7417DECFDFBEE8B3963EE7DD75B793E6A78E9EAAB9B963E9B8EAF5A847F2BC6F6399F40F6990580ECAF00F50F0AC42137E5811173C59C830B3734203E9B8E20D0C2E3F9275FD8F4E6DFD04BC5562B1210002A6A86ADD42B100746';
wwv_flow_imp.g_varchar2_table(55) := '1CDCA7EE30E688B94E9DC7FD04089C2AE07E01C06B8040A1401CDC7180170EBF6758DC1B73DC73C113040810584140005801DD92ED0AC4011E07F9D80AE29EB877EC7DC61320308F8059371B01C0AB80C0488138C8E3402FBD2DC6C63DA5E38D234080C0';
wwv_flow_imp.g_varchar2_table(56) := '120202C012CAD6E84E200EF438D8870A8B313176689CEB04082C2960AD10100042C183C0110271B0C701BFEFD6B81663F65DF73C010204D6141000D6D4B776F30271C0C78FBE6D7F0EFEAB5F3ADB6C7FCE3CAE355FA002087428A0A43B0202C01D07FF25';
wwv_flow_imp.g_varchar2_table(57) := '7092C0F6E7E0BFF3ADEF6FFC9CF949946E264060210101602168CB10204080400D02F6B0151000B612DE12204080008144020240A2662B95000102D905D4FF998000F09985F70810204080401A0101204DAB154A800081EC02EABF2820005CD4F03E0102';
wwv_flow_imp.g_varchar2_table(58) := '040810482220002469B432091020905D40FD770B0800777BF8880001020408A410100052B45991040810C82EA0FECB0202C065111F1320408000810402024082262B91000102D905D47FAF800070AF8967081020408040F7020240F72D5620010204B20B';
wwv_flow_imp.g_varchar2_table(59) := 'A87F978000B04BC5730408102040A0730101A0F3062B8F000102D905D4BF5B4000D8EDE2590204081020D0B58000D0757B1547800081EC02EADF272000EC93F13C0102040810E8584000E8B8B94A234080407601F5EF171000F6DBB8428000010204BA15';
wwv_flow_imp.g_varchar2_table(60) := '1000BA6DADC2081020905D40FD87040480433AAE1120408000814E0504804E1BAB2C020408641750FF610101E0B08FAB0408102040A04B0101A0CBB62A8A000102D905D43F2420000C09B94E80000102043A1410003A6CAA92081020905D40FDC30202C0';
wwv_flow_imp.g_varchar2_table(61) := 'B091110408102040A03B0101A0BB962A88000102D905D45F2220009428194380000102043A1310003A6BA872081020905D40FD65020240999351049A1578FFC37737AFBCF5F2F9E3EDEB6F345B8B8D1320309D8000309DA5990854271087FF8F7EF2C3CD';
wwv_flow_imp.g_varchar2_table(62) := 'F5F77F7EFEF8E9CF7EBC79F1B56BD5EDD586084C236096520101A054CA38028D096C0FFF7DDB8EAF0AECBBE6790204FA171000FAEFB10A130A0C1DFE0949949C444099E5020240B99591049A10283DFC3FF9F80F4DD463930408CC232000CCE36A5602AB';
wwv_flow_imp.g_varchar2_table(63) := '08941EFEB1B947BEF28D78E341A02301A58C111000C668194BA0628131877F94F1C4D933F1C6830081A4020240D2C62BBB2F81B187FF77BFFD83BE00544360B3D940182720008CF3329A407502C71CFE571E7878B23A62FDF88982F8D1C2161E7E0FC264';
wwv_flow_imp.g_varchar2_table(64) := 'AD3751E3020240E30DB4FDDC0271F8C6CFF9972AC467FE531EFEB16EAC1FBF6720DE6FE1B1FD3D0861D7C27EEDB154C0B8B10202C05831E30954221007581CBEA5DB99E3F06FF9B3E937DF79BD94CE38025D0A08005DB65551BD0BD470F887717C361D6F';
wwv_flow_imp.g_varchar2_table(65) := '5B7CB4F4558B167D97DEB3F5C60B0800E3CDDC416055815A0EFF55112C4E80C0C90202C0C9842620B09C406D87FFD99547972B7EE2959E7EFCB9896734DD7A02563E4640003846CD3D045610A8EDF00F82A71E7B36DE34F9F07B109A6C9B4D4F2820004C';
wwv_flow_imp.g_varchar2_table(66) := '88692A027309D478F847ADF113052F5D7D75D3D267D3F1558BF886C8D8BF471F02AA384E400038CECD5D041613A8F5F0BF08109F4D471068E1F1FC932F6C22B85CDCBFF7096414100032765DCDCD08B470F8378369A39D0A28EB580101E05839F7119859';
wwv_flow_imp.g_varchar2_table(67) := 'C0E13F33B0E9092417100092BF00945FA780C3BFCEBED8557D027674BC800070BC9D3B09CC22E0F09F85D5A404085C1210002E81F890C09A020EFF35F5ADDD9E801D9F2220009CA2E75E02130A38FC27C434150102830202C020910104E61770F8CF6F6C';
wwv_flow_imp.g_varchar2_table(68) := '85FE0454749A8000709A9FBB3B1178E5AD9737F178F1B56B9BA5FF853B877F272F226510684C400068AC61B63BBD401CFAF12FC3C523668F7FE12E9E8B83393E9EF3116BACFD4FFACE599FB909CC2760E6530504805305DDDFB4C0A1CFF6E3608E037AAE';
wwv_flow_imp.g_varchar2_table(69) := '0263EE58A374FEF8F5B57E835DA9967104080C0908004342AE772DF0DE07BF38585F1CD071501F1C74C4C59833E62EBDD5E15F2A655C1601759E2E20009C6E6886CE05E2A08E037BAA3263AE98B3743E877FA9947104088C111000C668199B56200EEC38';
wwv_flow_imp.g_varchar2_table(70) := 'B84F05883962AED2791CFEA552C6E51250ED140202C0148AE66856E0DA37BF57BCF738B8E3002FBEE1D2C0B837E6B8F4F4DE0F1DFE7B695C20406002010160024453B42B70DF7DF76DE2A02DAD200EF038C84BC76FC7C53D71EFF6E3A1B7B127DFF037A4';
wwv_flow_imp.g_varchar2_table(71) := 'E47A5601754F2320004CE368968605E2A08D03B7B48438C8E3402F1D1F63E39ED2F1B197D853E9F8B5C7457DDBDFA1103F3E59FBE3D04F7EAC6D697D024B0A08004B6A5BAB5A813870E3E02DDD601CE871F00D8D8F31317668DCF67AEC21F6B2FDB885B7';
wwv_flow_imp.g_varchar2_table(72) := '51DFF67728B4B0DF257FCF430B1EEDEDD18EA7121000A692344FF30271F0C6015C5A481C7C71C0EF1B1FD762CCBEEB979F8FB5630F979FAFF9E3963F9B7EF39DD76BA6B53702B30B0800B3135BA025813880E3202EDD731CF071D05F1E1FCFC5B5CBCFEF';
wwv_flow_imp.g_varchar2_table(73) := 'FB38D68CB5F75DAFF5F9F86CBAD6BD0DEDABA5AF5A0CD592E9BA5AA7131000A6B3345327027110C7815C5A4E1CF471E06FC7C7FBF1DCF6E3A1B7B156AC3934CE750204084C2920004CA969AE6E04E2408E83B9B4A038F0E3E08F47BC5F7A5FAC116B958E';
wwv_flow_imp.g_varchar2_table(74) := 'AF6DDCD995476BDB52F17E9E7EFCB9E2B106D622601F530A0800536A9AAB2B813898E3802E2D2A0EFE78948E8FB9638DD2F1358E7BEAB1676BDC56D19E9E387BA6689C41047A1510007AEDACBA261188033A0EEA4926BB3049CC19735F78AAC977A38697';
wwv_flow_imp.g_varchar2_table(75) := 'AEBEBA69E9B3E9F8AA45F837099E7CD3CA9F56400098D6D36C1D0AC42137E5811173C59C3D51C567D311045A783CFFE40B9BDEFC7B7A2DA96539010160396B2B352C1007461CDCA7961073C45CA7CEE37E02F904543CB5800030B5A8F9BA1588833B0EF0';
wwv_flow_imp.g_varchar2_table(76) := '630B8C7B638E63EF771F010204A6141000A6D43457F7027180C7413EB6D0B827EE1D7B9FF10408DC11F0DFE9050480E94DCDD8B9401CE471A097961963E39ED2F1C6112040600901016009656B742710077A1CEC4385C598183B34CE7502040E09B83687';
wwv_flow_imp.g_varchar2_table(77) := '80003087AA395308C4C11E07FCBE62E35A8CD977DDF3040810585340005853DFDACD0BC4011F3FFAB6FD39F8AF7EE96CB3FD39F3B8D67C810A205081802DCC232000CCE36AD66402DB9F83FFCEB7BEBFF173E6C99AAF5C028D0A08008D36CEB609102090';
wwv_flow_imp.g_varchar2_table(78) := '4340957309080073C99A970001020408542C200054DC1C5B234080407601F5CF272000CC676B66020408102050AD8000506D6B6C8C000102D905D43FA7800030A7AEB9091020408040A5020240A58DB12D020408641750FFBC0202C0BCBE662740800001';
wwv_flow_imp.g_varchar2_table(79) := '02550A080055B6C5A6081020905D40FD730B0800730B9B9F00010204085428200054D8145B224080407601F5CF2F2000CC6F6C050204081020509D8000505D4B6C88000102D905D4BF848000B084B23508102040804065020240650DB11D020408641750';
wwv_flow_imp.g_varchar2_table(80) := 'FF320202C032CE562140800001025509080055B5C366081020905D40FD4B0908004B495B8700010204085424200054D40C5B214080407601F52F2720002C676D250204081020508D8000504D2B6C84000102D905D4BFA48000B0A4B6B508102040804025';
wwv_flow_imp.g_varchar2_table(81) := '020240258DB00D020408641750FFB20202C0B2DE562340800001025508080055B421EF26FEF4F37F72B0F8F73F7CF7E0751709D42A30F4DA1D7AEDD75AD77CFB32F3D20202C0D2E2D61B25F05FBFFACF51E30D26508B80D76E2D9DB08F7D0202C03E19CF';
wwv_flow_imp.g_varchar2_table(82) := '5721F0DE07BFA8621F364160ACC04F7FF6E383B77CEEF37F7CF07AB68BEA5D5E400058DEDC8A1704EE7FF0F3173EBAF7DDEBEFFF7CF3F6F537EEBDE01902150B78CD56DC1C5B3B171000CE29BCB386C0E706BE0720F6149F49F90335243C5A1088D76ABC';
wwv_flow_imp.g_varchar2_table(83) := '6687F67AFF837F363424D175A5AE212000ACA16ECDBB04EEFFC2E1AF02C4E0F80335FE608DF73D08D42A10AFD15FC31D7A0000087B4944415478AD0EEDAFE4353F3487EB044E1510004E1574FFC902A59F09C51FAC2FBE76EDF65F090C7D87F5C99B3201';
wwv_flow_imp.g_varchar2_table(84) := '814281782DC6C1FFCA5B2F6FE2355A725BE96BBE64AE1EC6A8611D0101601D77AB5E1218F31951FC21FBA39FFC701361C0E31A875BA170CDD741BC16E33519DFAF72E965BDF3C331AFF59D137892C0440202C04490A6394D203E23F273D1A719BABB7E81';
wwv_flow_imp.g_varchar2_table(85) := '788DC76BBDFE9D2EB9436BAD252000AC256FDD7B041EFCF29F6FE20FC87B2E7882402702F11AEFA414657420200074D0C49E4A18FAB1C09E6A554B1E8108B67F792BE0E6A9B8BC5223D7131000D6B3B7F20E81F8B1C0BF7EF8415F09D861E3A93605E2F0';
wwv_flow_imp.g_varchar2_table(86) := '8FCFFCE3B5DD660576DDAB8000D06B671BAF2BFEC0F4CD528D37D1F637F11A8ED7328A7D029E5F5340005853DFDA0705E29BA5E2AB01F187E8C1812E12A84C205EB3B75FBB7ED94F659DB19D8B0202C0450DEF5729703108C41FACF125D57854B9599B4A';
wwv_flow_imp.g_varchar2_table(87) := '2710AFC5ED23FE9EDFC15FFE1230725D0101605D7FAB8F108820108FF8926A3CE20F5A8F07370CD63588D7E2F6E1EFF947FC3FB4A1AB0B0800ABB7C006081020905140CD6B0B08006B77C0FA0408102040600501016005744B12204020BB80FAD7171000';
wwv_flow_imp.g_varchar2_table(88) := 'D6EF811D102040800081C5050480C5C92D48800081EC02EAAF414000A8A10BF6408000010204161610001606B71C010204B20BA8BF0E0101A08E3ED8050102040810585440005894DB62040810C82EA0FE5A0404805A3A611F0408102040604101016041';
wwv_flow_imp.g_varchar2_table(89) := '6C4B11204020BB80FAEB111000EAE9859D102040800081C5040480C5A82D44800081EC02EAAF494000A8A91BF6428000010204161210001682B60C010204B20BA8BF2E0101A0AE7ED80D0102040810584440005884D922040810C82EA0FEDA040480DA3A';
wwv_flow_imp.g_varchar2_table(90) := '623F0408102040600101016001644B10204020BB80FAEB131000EAEB891D112040800081D9050480D9892D40800081EC02EAAF514000A8B12BF6448000010204661610006606363D010204B20BA8BF4E0101A0CEBED8150102040810985540009895D7E4';
wwv_flow_imp.g_varchar2_table(91) := '040810C82EA0FE5A0504805A3B635F04081020406046010160465C5313204020BB80FAEB151000EAED8D9D112040800081D9040480D9684D4C800081EC02EAAF594000A8B93BF6468000010204661210006682352D010204B20BA8BF6E0101A0EEFED81D';
wwv_flow_imp.g_varchar2_table(92) := '0102040810984540009885D5A4040810C82EA0FEDA050480DA3B647F0408102040600601016006545312204020BB80FAEB171000EAEF911D122040800081C9050480C9494D48800081EC02EA6F41400068A14BF6488000010204261610002606351D0102';
wwv_flow_imp.g_varchar2_table(93) := '04B20BA8BF0D0101A08D3ED9250102040810985440009894D364040810C82EA0FE56040480563A659F04081020406042010160424C5311204020BB80FADB111000DAE9959D122040800081C9040480C9284D44800081EC02EA6F49400068A95BF64A8000';
wwv_flow_imp.g_varchar2_table(94) := '010204261210002682340D010204B20BA8BF2D0101A0AD7ED92D0102040810984440009884D124040810C82EA0FED6040480D63A66BF0408102040600201016002445310204020BB80FADB131000DAEB991D1320408000819305048093094D40800081EC';
wwv_flow_imp.g_varchar2_table(95) := '02EA6F51400068B16BF64C80000102044E1410004E04743B010204B20BA8BF4D0101A0CDBED9350102040810384940003889CFCD040810C82EA0FE56050480563B67DF0408102040E0040101E0043CB712204020BB80FADB151000DAED9D9D1320408000';
wwv_flow_imp.g_varchar2_table(96) := '81A3050480A3E9DC48800081EC02EA6F59400068B97BF64E80000102048E1410008E84731B010204B20BA8BF6D0101A0EDFED93D0102040810384A4000388ACD4D040810C82EA0FED6050480D63B68FF0408102040E0080101E00834B710204020BB80FA';
wwv_flow_imp.g_varchar2_table(97) := 'DB171000DAEFA10A0810204080C06801016034991B081020905D40FD3D0808003D74510D040810204060A480003012CC700204086417507F1F0202401F7D54050102040810182520008CE23298000102D905D4DF8B8000D04B27D5418000010204460808';
wwv_flow_imp.g_varchar2_table(98) := '0023B00C254080407601F5F7232000F4D34B95102040800081620101A098CA400204086417507F4F0202404FDD540B0102040810281410000AA10C234080407601F5F7252000F4D54FD5102040800081220101A088C9200204086417507F6F0202406F1D';
wwv_flow_imp.g_varchar2_table(99) := '550F0102040810281010000A900C214080407601F5F7272000F4D753151120408000814101016090C8000204086417507F8F0202408F5D551301020408101810100006805C264080407601F5F7292000F4D95755112040800081830202C0411E17091020';
wwv_flow_imp.g_varchar2_table(100) := '905D40FDBD0A0800BD76565D0408102040E08080007000C7250204086417507FBF020240BFBD55190102040810D82B2000ECA57181000102D905D4DFB38000D07377D5468000010204F60808007B603C4D800081EC02EAEF5B4000E8BBBFAA2340800001';
wwv_flow_imp.g_varchar2_table(101) := '023B0504809D2C9E244080407601F5F72E2000F4DE61F51120408000811D0202C00E144F11204020BB80FAFB171000FAEFB10A0910204080C03D0202C03D249E204080407601F5671010003274598D0408102040E09280007009C487040810C82EA0FE1C';
wwv_flow_imp.g_varchar2_table(102) := '0202408E3EAB920001020408DC252000DCC5E1030204086417507F160101204BA7D54980000102042E0808001730BC4B800081EC02EACF232000E4E9B54A0910204080C0B98000704EE11D0204086417507F2601012053B7D54A80000102043E1510003E';
wwv_flow_imp.g_varchar2_table(103) := '85F086000102D905D49F4B4000C8D56FD5122040800081DB0202C06D06FF214080407601F567131000B2755CBD0408102040E0968000700BC1FF081020905D40FDF90404807C3D57310102040810D808005E04040810482F0020A3800090B1EB6A264080';
wwv_flow_imp.g_varchar2_table(104) := '0081F4020240FA9700000204B20BA83FA7800090B3EFAA2640800081E4020240F21780F20910C82EA0FEAC020240D6CEAB9B00010204520B0800A9DBAF780204B20BA83FAF800090B7F72A2740800081C4020240E2E62B9D0081EC02EACF2C200064EEBE';
wwv_flow_imp.g_varchar2_table(105) := 'DA0910204020AD800090B6F50A274020BB80FA730BFC3F000000FFFF277D99AA0000000649444154030028479CF1B17F70660000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(11387207814088183)
,p_file_name=>'icons/app-icon-512.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(11388566829088183)
,p_name=>'Administration Rights'
,p_static_id=>'administration-rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'plsql_function_body', 'return true;')).to_clob
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_version_scn=>'SH256:K94FzTYWdjDQ6WIg6w48Or20nhyD_tWnqCuRh9rK4CU'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/agents_name
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(11402967128088207)
,p_lov_name=>'AGENTS.NAME'
,p_static_id=>'agents-name'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'AGENTS'
,p_return_column_name=>'AGENT_ID'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>'SH256:fBajuzq7r8L1de0zjCq3Zhx7JA9sT3E11tcXsxySl7A'
);
end;
/
prompt --application/shared_components/user_interface/lovs/boolean
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(11474836469088296)
,p_lov_name=>'BOOLEAN'
,p_static_id=>'boolean'
,p_lov_query=>'.'||wwv_flow_imp.id(11474836469088296)||'.'
,p_location=>'STATIC'
,p_version_scn=>'SH256:CnCBOq-zabcz-aPWKwU8C5KDeZy6YuyjvpJoTrTywfI'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(11475523327088297)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'No'
,p_lov_return_value=>'FALSE'
,p_static_id=>'false'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(11475108475088296)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Yes'
,p_lov_return_value=>'TRUE'
,p_static_id=>'true'
);
end;
/
prompt --application/shared_components/user_interface/lovs/customers_company
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(11401575350088205)
,p_lov_name=>'CUSTOMERS.COMPANY'
,p_static_id=>'customers-company'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'CUSTOMERS'
,p_return_column_name=>'CUSTOMER_ID'
,p_display_column_name=>'COMPANY'
,p_default_sort_column_name=>'COMPANY'
,p_default_sort_direction=>'ASC'
,p_version_scn=>'SH256:uzy13PDjpaZrUJAP31Z_r1jMNCkNckn9XbuN5P6viok'
);
end;
/
prompt --application/shared_components/user_interface/lovs/products_name
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(11402290920088207)
,p_lov_name=>'PRODUCTS.NAME'
,p_static_id=>'products-name'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'PRODUCTS'
,p_return_column_name=>'PRODUCT_ID'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>'SH256:Rqg7yuN-PaoZh6az6X0md0QYCaypxBNPPyNEfGMj5y8'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(11388881550088184)
,p_group_name=>'Administration'
,p_static_id=>'administration'
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(11383762610088162)
,p_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(15168091654207549)
,p_short_name=>'Ask Atlas'
,p_static_id=>'ask-atlas'
,p_link=>'f?p=&APP_ID.:10:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(15968076509614525)
,p_short_name=>'Ask Your Data'
,p_static_id=>'ask-your-data'
,p_link=>'f?p=&APP_ID.:13:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>13
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(11383989087088163)
,p_short_name=>'Home'
,p_static_id=>'home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(11439377520088282)
,p_short_name=>'Knowledge Base'
,p_static_id=>'knowledge-base'
,p_link=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(15169471623212164)
,p_short_name=>'Knowledge Gaps'
,p_static_id=>'knowledge-gaps'
,p_link=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(11565209543359375)
,p_short_name=>'Search'
,p_static_id=>'search'
,p_link=>'f?p=&APP_ID.:8:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(15568065858511720)
,p_short_name=>'Ticket Workspace'
,p_static_id=>'ticket-workspace'
,p_link=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(11432519094088274)
,p_short_name=>'Tickets'
,p_static_id=>'tickets'
,p_link=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>2
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(11384622212088166)
,p_theme_id=>42
,p_static_id=>'universal-theme'
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'26.1'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_is_locked=>false
,p_current_theme_style_id=>2243014446517417
,p_default_page_template=>4073832297226169690
,p_default_dialog_template=>2101883943284197310
,p_error_template=>2102634289808461002
,p_printer_friendly_template=>4073832297226169690
,p_login_template=>2102634289808461002
,p_default_button_template=>4073839297780169708
,p_default_region_template=>4073835273271169698
,p_default_chart_template=>4073835273271169698
,p_default_form_template=>4073835273271169698
,p_default_reportr_template=>4073835273271169698
,p_default_wizard_template=>4073835273271169698
,p_default_menur_template=>2532939663579242476
,p_default_listr_template=>4073835273271169698
,p_default_irr_template=>2102002977963900996
,p_default_report_template=>2540130677583398057
,p_default_label_template=>1610598304472262251
,p_default_menu_template=>4073839682315169711
,p_default_list_template=>4073837480889169704
,p_default_top_nav_list_temp=>2528231041045349458
,p_default_side_nav_list_temp=>2469215554099805162
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>2127905476394690047
,p_default_dialogr_template=>4502917002193490937
,p_default_option_label=>1610598304472262251
,p_default_required_label=>1610598484065263269
,p_default_navbar_list_template=>2849019392706229583
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/26.1/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
,p_reference_id=>wwv_imp_util.get_subscription_id(4073840274158169736,2000,'universal-theme',8842.261)
,p_version_scn=>'SH256:RQZ7_KKNFF7leXIrwskeQw4WaazlZwly2sNGWk8hwQo'
,p_version_scn_master=>'SH256:WOPVC8vP1TPWUxczh2dJ4mCZcNGSTzA1cn8DjR2oQjY'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(11383068788088159)
,p_build_option_name=>'Commented Out'
,p_static_id=>'commented-out'
,p_build_option_status=>'EXCLUDE'
,p_version_scn=>'SH256:1lQI3DW9n-0ZEGoDXUirkaB0JWCIATVWpJZCTCkODmI'
);
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/security/authentications/open_door_screenshots
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(11478504394102674)
,p_name=>'Open Door (screenshots)'
,p_static_id=>'open-door-screenshots'
,p_scheme_type=>'NATIVE_OPEN_DOOR'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>'SH256:AyEe0Aqd-GRCl57wvSszl8FK4eEgZT_VJ2lNkrJaYBk'
);
end;
/
prompt --application/shared_components/security/authentications/oracle_apex_accounts
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(11383355432088161)
,p_name=>'Oracle APEX Accounts'
,p_static_id=>'oracle-apex-accounts'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>'SH256:MwlwV9vQNyvTGV3nRFfTrp5n7mJ1Ugme2lUrlsOYuxw'
);
end;
/
prompt --application/shared_components/navigation/search_config/knowledge_base
begin
wwv_flow_imp_shared.create_search_config(
 p_id=>wwv_flow_imp.id(11563284150308390)
,p_label=>'Knowledge Base'
,p_static_id=>'knowledge-base'
,p_search_type=>'VECTOR'
,p_query_type=>'TABLE'
,p_query_table=>'KB_ARTICLES'
,p_oratext_index_column_name=>'EMBEDDING'
,p_vector_provider_id=>11502018688172262
,p_vector_search_type=>'EXACT'
,p_vector_distance_metric=>'COSINE'
,p_vector_maximum_distance=>.8
,p_return_max_results=>5
,p_pk_column_name=>'ARTICLE_ID'
,p_title_column_name=>'TITLE'
,p_description_column_name=>'BODY'
,p_icon_source_type=>'INITIALS'
,p_version_scn=>'SH256:w0Ypjbqk8pJmo9LiCRL6cD74Vkzi8BPf8wSB0gt9O9I'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_reload_on_submit=>null
,p_warn_on_unsaved_changes=>null
,p_autocomplete_on_off=>'OFF'
,p_protection_level=>'D'
,p_page_component_map=>'14'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Atlas Support'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'13'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11399375700088196)
,p_plug_name=>'Atlas Support'
,p_static_id=>'atlas-support'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11474486858088296)
,p_plug_name=>'Page Navigation'
,p_static_id=>'page-navigation'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--featured t-Cards--block force-fa-lg:t-Cards--displayIcons:t-Cards--4cols:t-Cards--hideBody:t-Cards--animColorFill'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_list_id=>wwv_flow_imp.id(11473198219088295)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2888245825625742894
,p_plug_query_num_rows=>15
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(13766841855587601)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11399375700088196)
,p_button_name=>'ASK_ASSISTANT'
,p_static_id=>'ask-assistant'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ask Atlas'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-comments-o'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(13766947858587602)
,p_name=>'Open Assistant'
,p_static_id=>'open-assistant'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(13766841855587601)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13767065391587603)
,p_event_id=>wwv_flow_imp.id(13766947858587602)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-open-ai-assistant'
,p_action=>'NATIVE_OPEN_AI_ASSISTANT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'DIALOG',
  'quick_action_message1', 'Can I get my money back for a duplicate charge?',
  'quick_action_message2', 'What is the status of ticket 15?',
  'title', 'Ask Atlas')).to_clob
,p_ai_agent_id=>wwv_flow_imp.id(13366944066512216)
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Tickets'
,p_alias=>'TICKETS'
,p_step_title=>'Tickets'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11431971561088273)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11421259446088256)
,p_plug_name=>'Tickets'
,p_static_id=>'tickets'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ticket_id, t.subject, c.company as customer, p.name as product,',
'       t.priority, t.status, t.category, t.created_at',
'from   tickets t',
'join   customers c on c.customer_id = t.customer_id',
'join   products p on p.product_id = t.product_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>true
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(11421378723088256)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:RP:P3_TICKET_ID:\#TICKET_ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>11421378723088256
,p_ai_search_mode=>'A'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11425814024088267)
,p_db_column_name=>'CATEGORY'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Category'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11426633313088267)
,p_db_column_name=>'CREATED_AT'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Created At'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11479772101127304)
,p_db_column_name=>'CUSTOMER'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Customer'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11425085886088266)
,p_db_column_name=>'PRIORITY'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Priority'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11479892210127305)
,p_db_column_name=>'PRODUCT'
,p_display_order=>31
,p_column_identifier=>'V'
,p_column_label=>'Product'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11425431626088266)
,p_db_column_name=>'STATUS'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11424234617088265)
,p_db_column_name=>'SUBJECT'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Subject'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11422609907088261)
,p_db_column_name=>'TICKET_ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Ticket ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(11440086458088285)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'primary'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SUBJECT:PRIORITY:STATUS:CATEGORY:CREATED_AT'
,p_sort_column_1=>'CUSTOMER_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11430646020088271)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11421259446088256)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:3::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14169151946670701)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11421259446088256)
,p_button_name=>'TRIAGE'
,p_static_id=>'triage'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Triage Agent'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-robot'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(11431016033088272)
,p_name=>'Edit Report - Dialog Closed'
,p_static_id=>'edit-report-dialog-closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(11421259446088256)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(11431469830088272)
,p_event_id=>wwv_flow_imp.id(11431016033088272)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(11421259446088256)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14169296798670702)
,p_name=>'Open Triage Agent'
,p_static_id=>'open-triage-agent'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(14169151946670701)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14169392054670703)
,p_event_id=>wwv_flow_imp.id(14169296798670702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-open-ai-assistant'
,p_action=>'NATIVE_OPEN_AI_ASSISTANT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'DIALOG',
  'title', 'Triage Agent')).to_clob
,p_ai_agent_id=>wwv_flow_imp.id(14166989233632689)
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'Ticket'
,p_alias=>'TICKET'
,p_page_mode=>'MODAL'
,p_step_title=>'Ticket'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1662662927374504442
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_chained=>'N'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11417104078088210)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_item_display_point=>'ABOVE'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11400630588088203)
,p_plug_name=>'Ticket'
,p_static_id=>'ticket'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'TICKETS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11417588565088210)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11417104078088210)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA_ACTION'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_component_da_action(
 p_id=>wwv_flow_imp.id(11418032944088210)
,p_button_id=>wwv_flow_imp.id(11417588565088210)
,p_action_sequence=>10
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_static_id=>'native-dialog-cancel'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11419314440088211)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(11417104078088210)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_condition=>'P3_TICKET_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11418504373088211)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(11417104078088210)
,p_button_name=>'DELETE'
,p_static_id=>'delete'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P3_TICKET_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11418972663088211)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(11417104078088210)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P3_TICKET_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14568912985751702)
,p_button_sequence=>220
,p_button_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_button_name=>'SUGGEST_REPLY'
,p_static_id=>'suggest-reply'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Suggest Reply'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-magic'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11402804093088207)
,p_name=>'P3_AGENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Agent'
,p_source=>'AGENT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'AGENTS.NAME'
,p_lov_display_null=>'YES'
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11408714103088209)
,p_name=>'P3_AI_CATEGORY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'AI Category'
,p_source=>'AI_CATEGORY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11410396237088209)
,p_name=>'P3_AI_DONE_AT'
,p_source_data_type=>'TIMESTAMP'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'AI Done At'
,p_source=>'AI_DONE_AT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11409100507088209)
,p_name=>'P3_AI_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'AI Priority'
,p_source=>'AI_PRIORITY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11409590205088209)
,p_name=>'P3_AI_SENTIMENT'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'AI Sentiment'
,p_source=>'AI_SENTIMENT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11409977677088209)
,p_name=>'P3_AI_SUMMARY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'AI Summary'
,p_source=>'AI_SUMMARY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11405192077088208)
,p_name=>'P3_CATEGORY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Category'
,p_source=>'CATEGORY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11405596194088208)
,p_name=>'P3_CHANNEL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Channel'
,p_source=>'CHANNEL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11405962594088208)
,p_name=>'P3_CREATED_AT'
,p_source_data_type=>'TIMESTAMP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Created At'
,p_source=>'CREATED_AT'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11401457940088205)
,p_name=>'P3_CUSTOMER_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Customer'
,p_source=>'CUSTOMER_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'CUSTOMERS.COMPANY'
,p_lov_display_null=>'YES'
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11403974018088207)
,p_name=>'P3_DESCRIPTION'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11404378304088207)
,p_name=>'P3_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Priority'
,p_source=>'PRIORITY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11402185945088207)
,p_name=>'P3_PRODUCT_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Product'
,p_source=>'PRODUCT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'PRODUCTS.NAME'
,p_lov_display_null=>'YES'
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(14568825481751701)
,p_name=>'P3_REPLY'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Suggested Reply'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11406715594088208)
,p_name=>'P3_RESOLVED_AT'
,p_source_data_type=>'TIMESTAMP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Resolved At'
,p_source=>'RESOLVED_AT'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11407583362088209)
,p_name=>'P3_SATISFACTION'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Satisfaction'
,p_source=>'SATISFACTION'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11404730778088208)
,p_name=>'P3_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Status'
,p_source=>'STATUS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11403593518088207)
,p_name=>'P3_SUBJECT'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Subject'
,p_source=>'SUBJECT'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>200
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11401020004088204)
,p_name=>'P3_TICKET_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_item_source_plug_id=>wwv_flow_imp.id(11400630588088203)
,p_prompt=>'Ticket ID'
,p_source=>'TICKET_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_field_template=>1610598484065263269
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(11410786153088209)
,p_validation_name=>'P3_AI_DONE_AT must be timestamp'
,p_static_id=>'p3-ai-done-at-must-be-timestamp'
,p_validation_sequence=>190
,p_validation=>'P3_AI_DONE_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(11410396237088209)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(11406332188088208)
,p_validation_name=>'P3_CREATED_AT must be timestamp'
,p_static_id=>'p3-created-at-must-be-timestamp'
,p_validation_sequence=>100
,p_validation=>'P3_CREATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(11405962594088208)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(11407113353088208)
,p_validation_name=>'P3_RESOLVED_AT must be timestamp'
,p_static_id=>'p3-resolved-at-must-be-timestamp'
,p_validation_sequence=>110
,p_validation=>'P3_RESOLVED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(11406715594088208)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14574240765771301)
,p_name=>'Suggest Reply'
,p_static_id=>'suggest-reply'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(14568912985751702)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14574385003771302)
,p_event_id=>wwv_flow_imp.id(14574240765771301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-generate-text-ai'
,p_action=>'NATIVE_GENERATE_TEXT_AI'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_value_item', 'P3_DESCRIPTION',
  'input_value_type', 'ITEM',
  'suppress_change_event', 'N',
  'use_response_item', 'P3_REPLY',
  'use_response_type', 'ITEM')).to_clob
,p_wait_for_result=>'Y'
,p_ai_agent_id=>wwv_flow_imp.id(13366944066512216)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14766928927790501)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Classify New Ticket'
,p_static_id=>'classify-new-ticket'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the new ticket is classified like the others (Chapter 11)',
'classify_tickets;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(11419314440088211)
,p_internal_uid=>14766928927790501
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11420582359088211)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_success_messages', 'Y')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>11420582359088211
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11419797845088211)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(11400630588088203)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Ticket'
,p_static_id=>'initialize-form-ticket'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'current_row_total_item', '',
  'next_primary_key_items', '',
  'previous_primary_key_items', '')).to_clob
,p_internal_uid=>11419797845088211
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11420199865088211)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(11400630588088203)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Ticket'
,p_static_id=>'process-form-ticket'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11420199865088211
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_imp_page.create_page(
 p_id=>4
,p_name=>'Knowledge Base'
,p_alias=>'KNOWLEDGE-BASE'
,p_step_title=>'Knowledge Base'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11438787902088282)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11433904477088275)
,p_plug_name=>'Kb Articles'
,p_static_id=>'knowledge-base'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select article_id, title, updated_on',
'from   kb_articles'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(11434062604088275)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>11434062604088275
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11435322435088278)
,p_db_column_name=>'ARTICLE_ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Article ID'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11436192085088279)
,p_db_column_name=>'TITLE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Title'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(11436978692088280)
,p_db_column_name=>'UPDATED_ON'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Updated On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(11467642371088293)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'primary'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ARTICLE_ID:TITLE'
,p_sort_column_1=>'ARTICLE_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11438015277088281)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(11433904477088275)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_imp_page.create_page(
 p_id=>8
,p_name=>'Search'
,p_alias=>'SEARCH'
,p_step_title=>'Search'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'26'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11564609416359374)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11565407346359376)
,p_plug_name=>'Search Results'
,p_static_id=>'search-results'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>1557215235004102827
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_source_type=>'NATIVE_SEARCH_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'custom_layout', 'N',
  'lazy_loading', 'Y',
  'minimum_characters', '0',
  'no_query_entered_message', 'Please enter your search term.',
  'no_results_found_message', 'No results for your search term.',
  'results_per_page', '15',
  'results_per_page_type', 'STATIC',
  'search_as_you_type', 'N',
  'search_page_item', 'P8_SEARCH',
  'show_result_count', 'N',
  'use_pagination', 'Y')).to_clob
);
wwv_flow_imp_page.create_search_region_source(
 p_id=>wwv_flow_imp.id(11565806207359376)
,p_region_id=>wwv_flow_imp.id(11565407346359376)
,p_search_config_id=>wwv_flow_imp.id(11563284150308390)
,p_use_as_initial_result=>false
,p_display_sequence=>10
,p_name=>'Knowledge Base'
,p_static_id=>'knowledge-base'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11566479768359378)
,p_name=>'P8_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(11564609416359374)
,p_item_display_point=>'SMART_FILTERS'
,p_prompt=>'Search'
,p_placeholder=>'Search...'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_field_template=>2042262243893469891
,p_item_css_classes=>'mxw800 t-Form-fieldContainer--noPadding'
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'SEARCH',
  'trim_spaces', 'BOTH')).to_clob
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_imp_page.create_page(
 p_id=>10
,p_name=>'Ask Atlas'
,p_alias=>'ASK-ATLAS'
,p_step_title=>'Ask Atlas'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15175468782217904)
,p_plug_name=>'Answer'
,p_static_id=>'answer'
,p_title=>'Answer'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the answer, escaped, as a paragraph',
'for r in (select answer from ka_questions where question_id = :P10_QUESTION_ID) loop',
'  return ''<p>'' || apex_escape.html(r.answer) || ''</p>'';',
'end loop;',
'return null;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P10_QUESTION_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15167480220207544)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15169622559214801)
,p_plug_name=>'Your Question'
,p_static_id=>'new'
,p_title=>'Your Question'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15182634181227701)
,p_name=>'Sources'
,p_static_id=>'sources'
,p_title=>'Sources'
,p_template=>4073835273271169698
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.n as "No.", s.source as "Source", round(s.distance, 3) as "Distance"',
'from   ka_questions q,',
'       json_table(q.sources, ''$[*]'' columns (n        number        path ''$.n'',',
'                                             source   varchar2(200) path ''$.source'',',
'                                             distance number        path ''$.distance'')) s',
'where  q.question_id = :P10_QUESTION_ID',
'order  by s.n'))
,p_display_when_condition=>'P10_QUESTION_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15182904436227704)
,p_query_column_id=>3
,p_column_alias=>'Distance'
,p_column_display_sequence=>30
,p_column_heading=>'Distance'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15182739679227702)
,p_query_column_id=>1
,p_column_alias=>'No.'
,p_column_display_sequence=>10
,p_column_heading=>'No.'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15182829968227703)
,p_query_column_id=>2
,p_column_alias=>'Source'
,p_column_display_sequence=>20
,p_column_heading=>'Source'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15175205224217902)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(15169622559214801)
,p_button_name=>'ASK'
,p_static_id=>'ask'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ask'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15175689347217906)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(15175468782217904)
,p_button_name=>'HELPFUL'
,p_static_id=>'helpful'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'This helped'
,p_button_position=>'NEXT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from ka_questions',
'where  question_id = :P10_QUESTION_ID and outcome = ''Answered'' and helpful is null'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15175728368217907)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(15175468782217904)
,p_button_name=>'NOT_HELPFUL'
,p_static_id=>'not-helpful'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'This did not help'
,p_button_position=>'NEXT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from ka_questions',
'where  question_id = :P10_QUESTION_ID and outcome = ''Answered'' and helpful is null'))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15175135233217901)
,p_name=>'P10_QUESTION'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(15169622559214801)
,p_prompt=>'Question'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15175303281217903)
,p_name=>'P10_QUESTION_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(15169622559214801)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15189062181238701)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Answer the Question'
,p_static_id=>'answer-the-question'
,p_process_sql_clob=>':P10_QUESTION_ID := ka_ask(:P10_QUESTION, :APP_USER);'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15175205224217902)
,p_internal_uid=>15189062181238701
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15189110084238702)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Record Feedback'
,p_static_id=>'record-feedback'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update ka_questions',
'set    helpful = case :REQUEST when ''HELPFUL'' then ''Y'' else ''N'' end',
'where  question_id = :P10_QUESTION_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'HELPFUL,NOT_HELPFUL'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Thank you for your feedback.'
,p_internal_uid=>15189110084238702
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_imp_page.create_page(
 p_id=>11
,p_name=>'Knowledge Gaps'
,p_alias=>'KNOWLEDGE-GAPS'
,p_step_title=>'Knowledge Gaps'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15168876980212160)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15368266805297410)
,p_plug_name=>'Suggested Changes'
,p_static_id=>'suggested-changes'
,p_title=>'Suggested Changes'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the model''s proposals, escaped, one per line',
'return replace(apex_escape.html(:P11_SUGGESTIONS), chr(10), ''<br>'');'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15367394848297401)
,p_plug_name=>'Unanswered Questions'
,p_static_id=>'unanswered-questions'
,p_title=>'Unanswered Questions'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select q.question_id, q.asked_at, q.asked_by,',
'       case when q.helpful = ''N'' then ''Not helpful'' else q.outcome end as reason,',
'       q.question, n.source as nearest_source, round(n.distance, 3) as distance',
'from   ka_questions q',
'cross  apply (select k.source, vector_distance(k.embedding, q.embedding, cosine) as distance',
'              from   knowledge k',
'              order  by distance',
'              fetch  first 1 row only) n',
'where  q.outcome = ''Not found'' or q.helpful = ''N''',
'order  by n.distance'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Unanswered Questions'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(15367445730297402)
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>15367445730297402
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15367692396297404)
,p_db_column_name=>'ASKED_AT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Asked At'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15367725738297405)
,p_db_column_name=>'ASKED_BY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Asked By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15368131097297409)
,p_db_column_name=>'DISTANCE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Distance'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15368016700297408)
,p_db_column_name=>'NEAREST_SOURCE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nearest Source'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15367939948297407)
,p_db_column_name=>'QUESTION'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Question'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15367533321297403)
,p_db_column_name=>'QUESTION_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Question Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(15367898092297406)
,p_db_column_name=>'REASON'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Reason'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(15376833491303747)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'primary'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'QUESTION_ID:ASKED_AT:ASKED_BY:REASON:QUESTION:NEAREST_SOURCE:DISTANCE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15368356586297411)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(15368266805297410)
,p_button_name=>'SUGGEST'
,p_static_id=>'suggest'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Suggest Changes'
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15368457908297412)
,p_name=>'P11_SUGGESTIONS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(15368266805297410)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15368566494297413)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Suggest Changes'
,p_static_id=>'suggest-changes'
,p_process_sql_clob=>':P11_SUGGESTIONS := ka_suggest_articles;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15368356586297411)
,p_internal_uid=>15368566494297413
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_name=>'Ticket Workspace'
,p_alias=>'TICKET-WORKSPACE'
,p_step_title=>'Ticket Workspace'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15567486584511714)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15569920228513018)
,p_name=>'Conversation'
,p_static_id=>'conversation'
,p_title=>'Conversation'
,p_template=>4073835273271169698
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(created_at, ''YYYY-MM-DD HH24:MI'') as "Date", author_name as "From",',
'       body as "Message"',
'from   ticket_comments',
'where  ticket_id = :P12_TICKET_ID',
'order  by created_at'))
,p_display_when_condition=>'P12_TICKET_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15570078709513019)
,p_query_column_id=>1
,p_column_alias=>'Date'
,p_column_display_sequence=>10
,p_column_heading=>'Date'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15570198160513020)
,p_query_column_id=>2
,p_column_alias=>'From'
,p_column_display_sequence=>20
,p_column_heading=>'From'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15570200958513021)
,p_query_column_id=>3
,p_column_alias=>'Message'
,p_column_display_sequence=>30
,p_column_heading=>'Message'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15568498496513003)
,p_name=>'Details'
,p_static_id=>'details'
,p_title=>'Details'
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.company as "Customer", c.contact_name as "Contact",',
'       t.description as "Description",',
'       t.ai_category || '' / '' || t.ai_priority || '' / '' || t.ai_sentiment as "Classification",',
'       t.ai_summary as "Summary"',
'from   tickets t join customers c on c.customer_id = t.customer_id',
'where  t.ticket_id = :P12_TICKET_ID'))
,p_display_when_condition=>'P12_TICKET_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15766874251537101)
,p_query_column_id=>4
,p_column_alias=>'Classification'
,p_column_display_sequence=>40
,p_column_heading=>'Classification'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15568639359513005)
,p_query_column_id=>2
,p_column_alias=>'Contact'
,p_column_display_sequence=>20
,p_column_heading=>'Contact'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15568582678513004)
,p_query_column_id=>1
,p_column_alias=>'Customer'
,p_column_display_sequence=>10
,p_column_heading=>'Customer'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15568751871513006)
,p_query_column_id=>3
,p_column_alias=>'Description'
,p_column_display_sequence=>30
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15766942485537102)
,p_query_column_id=>5
,p_column_alias=>'Summary'
,p_column_display_sequence=>50
,p_column_heading=>'Summary'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15570316883513022)
,p_plug_name=>'Reply'
,p_static_id=>'reply'
,p_title=>'Reply'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P12_TICKET_ID'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15569027995513009)
,p_name=>'Similar Resolved Tickets'
,p_static_id=>'similar-resolved-tickets'
,p_title=>'Similar Resolved Tickets'
,p_template=>4073835273271169698
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ticket_id as "Ticket", round(vector_distance(t.embedding, x.embedding, cosine), 3)',
'         as "Distance",',
'       t.subject as "Subject",',
'       (select c.body',
'        from   ticket_comments c',
'        where  c.ticket_id = t.ticket_id and c.author_type = ''Agent''',
'        order  by c.created_at desc',
'        fetch  first 1 row only) as "Resolution"',
'from   tickets t, tickets x',
'where  x.ticket_id = :P12_TICKET_ID',
'and    t.ticket_id <> x.ticket_id',
'and    t.status in (''Resolved'', ''Closed'')',
'order  by 2',
'fetch  first 3 rows only'))
,p_display_when_condition=>'P12_TICKET_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569263179513011)
,p_query_column_id=>2
,p_column_alias=>'Distance'
,p_column_display_sequence=>20
,p_column_heading=>'Distance'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569413566513013)
,p_query_column_id=>4
,p_column_alias=>'Resolution'
,p_column_display_sequence=>40
,p_column_heading=>'Resolution'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569316495513012)
,p_query_column_id=>3
,p_column_alias=>'Subject'
,p_column_display_sequence=>30
,p_column_heading=>'Subject'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569184141513010)
,p_query_column_id=>1
,p_column_alias=>'Ticket'
,p_column_display_sequence=>10
,p_column_heading=>'Ticket'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15569533195513014)
,p_name=>'Suggested Articles'
,p_static_id=>'suggested-articles'
,p_title=>'Suggested Articles'
,p_template=>4073835273271169698
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.article_id as "Article", round(vector_distance(a.embedding, t.embedding, cosine), 3)',
'         as "Distance",',
'       a.title as "Title"',
'from   kb_articles a, tickets t',
'where  t.ticket_id = :P12_TICKET_ID',
'order  by 2',
'fetch  first 2 rows only'))
,p_display_when_condition=>'P12_TICKET_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569640131513015)
,p_query_column_id=>1
,p_column_alias=>'Article'
,p_column_display_sequence=>10
,p_column_heading=>'Article'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569779397513016)
,p_query_column_id=>2
,p_column_alias=>'Distance'
,p_column_display_sequence=>20
,p_column_heading=>'Distance'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15569867500513017)
,p_query_column_id=>3
,p_column_alias=>'Title'
,p_column_display_sequence=>30
,p_column_heading=>'Title'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15568259506513001)
,p_plug_name=>'Ticket'
,p_static_id=>'ticket'
,p_title=>'Ticket'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15570656913513025)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(15570316883513022)
,p_button_name=>'DRAFT'
,p_static_id=>'draft'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Draft Reply'
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15570711147513026)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(15570316883513022)
,p_button_name=>'SEND'
,p_static_id=>'send'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Send Reply'
,p_button_position=>'NEXT'
,p_button_condition=>'P12_REPLY_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15570480986513023)
,p_name=>'P12_REPLY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(15570316883513022)
,p_prompt=>'Reply to the customer'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>10
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15570541501513024)
,p_name=>'P12_REPLY_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(15570316883513022)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15568301004513002)
,p_name=>'P12_TICKET_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(15568259506513001)
,p_prompt=>'Ticket'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ticket_id || '' - '' || subject as d, ticket_id as r',
'from   tickets',
'where  status in (''Open'', ''In Progress'', ''Waiting'')',
'order  by ticket_id'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Select a ticket -'
,p_cHeight=>1
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15570801710513027)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Draft the Reply'
,p_static_id=>'draft-the-reply'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P12_REPLY_ID := hd_draft_reply(:P12_TICKET_ID, :APP_USER);',
'select draft into :P12_REPLY from hd_replies where reply_id = :P12_REPLY_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15570656913513025)
,p_internal_uid=>15570801710513027
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15570964335513028)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send the Reply'
,p_static_id=>'send-the-reply'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'hd_send_reply(:P12_REPLY_ID, :P12_REPLY);',
':P12_REPLY    := null;',
':P12_REPLY_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15570711147513026)
,p_process_success_message=>'The reply was sent to the customer.'
,p_internal_uid=>15570964335513028
);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_imp_page.create_page(
 p_id=>13
,p_name=>'Ask Your Data'
,p_alias=>'ASK-YOUR-DATA'
,p_step_title=>'Ask Your Data'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15968604011615805)
,p_plug_name=>'Answer'
,p_static_id=>'answer'
,p_title=>'Answer'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the sentence and the rows, or why there is no answer',
'for r in (select answer, error from ad_questions where question_id = :P13_QUESTION_ID) loop',
'  if r.error is not null then',
'    return ''<p>The question could not be answered: '' || apex_escape.html(r.error) || ''</p>'';',
'  end if;',
'  return ''<p>'' || apex_escape.html(r.answer) || ''</p>'' || ad_table_html(:P13_QUESTION_ID);',
'end loop;',
'return null;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P13_QUESTION_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15967422795614519)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_menu_id=>wwv_flow_imp.id(11383762610088162)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16166818451630401)
,p_plug_name=>'Chart'
,p_static_id=>'chart'
,p_title=>'Chart'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>25
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select 1 from ad_points where question_id = :P13_QUESTION_ID'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(16166972585630402)
,p_region_id=>wwv_flow_imp.id(16166818451630401)
,p_chart_type=>'bar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16167054196630403)
,p_chart_id=>wwv_flow_imp.id(16166972585630402)
,p_static_id=>'rows'
,p_seq=>10
,p_name=>'Rows'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select label, value',
'from   ad_points',
'where  question_id = :P13_QUESTION_ID',
'order  by seq'))
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(16167122742630404)
,p_chart_id=>wwv_flow_imp.id(16166972585630402)
,p_static_id=>'x'
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(16167251280630405)
,p_chart_id=>wwv_flow_imp.id(16166972585630402)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(15975262087625002)
,p_name=>'Recent Questions'
,p_static_id=>'recent-questions'
,p_title=>'Recent Questions'
,p_template=>4073835273271169698
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(asked_at, ''YYYY-MM-DD HH24:MI'') as "Asked",',
'       question as "Question",',
'       nvl(to_char(row_count), ''No answer'') as "Rows"',
'from   ad_questions',
'where  asked_by = :APP_USER',
'order  by asked_at desc',
'fetch  first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15975363046625003)
,p_query_column_id=>1
,p_column_alias=>'Asked'
,p_column_display_sequence=>10
,p_column_heading=>'Asked'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15975477120625004)
,p_query_column_id=>2
,p_column_alias=>'Question'
,p_column_display_sequence=>20
,p_column_heading=>'Question'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(15975596076625005)
,p_query_column_id=>3
,p_column_alias=>'Rows'
,p_column_display_sequence=>30
,p_column_heading=>'Rows'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15975110471625001)
,p_plug_name=>'The SQL Behind the Answer'
,p_static_id=>'the-sql-behind-the-answer'
,p_title=>'The SQL Behind the Answer'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- the generated query, as it ran',
'for r in (select sql_text from ad_questions where question_id = :P13_QUESTION_ID) loop',
'  return ''<pre>'' || apex_escape.html(r.sql_text) || ''</pre>'';',
'end loop;',
'return null;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P13_QUESTION_ID'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15968252073615801)
,p_plug_name=>'Your Question'
,p_static_id=>'your-question'
,p_title=>'Your Question'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15968462589615803)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(15968252073615801)
,p_button_name=>'ASK'
,p_static_id=>'ask'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ask'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15968330478615802)
,p_name=>'P13_QUESTION'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(15968252073615801)
,p_prompt=>'Question'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15968571434615804)
,p_name=>'P13_QUESTION_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(15968252073615801)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15975680142625006)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Ask the Data'
,p_static_id=>'ask-the-data'
,p_process_sql_clob=>':P13_QUESTION_ID := ad_ask(:P13_QUESTION, :APP_USER);'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15968462589615803)
,p_internal_uid=>15975680142625006
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'Atlas Support - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2102634289808461002
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'12'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11392371226088188)
,p_plug_name=>'Atlas Support'
,p_static_id=>'atlas-support'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675634334296186762
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11393992510088193)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(11392371226088188)
,p_button_name=>'LOGIN'
,p_static_id=>'login'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11393277949088191)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(11392371226088188)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="current-password"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11393652577088193)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(11392371226088188)
,p_prompt=>'Remember username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(11392859174088191)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(11392371226088188)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="username"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11398070507088195)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_static_id=>'clear-page-s-cache'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'type', 'CLEAR_CACHE_CURRENT_PAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11398070507088195
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11397619259088195)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_static_id=>'get-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>11397619259088195
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11394387458088193)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Login'
,p_static_id=>'login'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'LOGIN',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11394387458088193
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(11395347020088194)
,p_page_process_id=>wwv_flow_imp.id(11394387458088193)
,p_page_id=>9999
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_PASSWORD'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(11395890098088194)
,p_page_process_id=>wwv_flow_imp.id(11394387458088193)
,p_page_id=>9999
,p_name=>'p_set_persistent_auth'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>true
,p_display_sequence=>3
,p_value_type=>'API_DEFAULT'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(11394822695088194)
,p_page_process_id=>wwv_flow_imp.id(11394387458088193)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'ITEM'
,p_value=>'P9999_USERNAME'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(11396229085088194)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Set Username Cookie'
,p_static_id=>'set-username-cookie'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'SEND_LOGIN_USERNAME_COOKIE',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>11396229085088194
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(11397268986088194)
,p_page_process_id=>wwv_flow_imp.id(11396229085088194)
,p_page_id=>9999
,p_name=>'p_consent'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_REMEMBER'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(11396736976088194)
,p_page_process_id=>wwv_flow_imp.id(11396229085088194)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'EXPRESSION'
,p_value_language=>'PLSQL'
,p_value=>'lower( :P9999_USERNAME )'
);
end;
/
prompt --application/deployment/definition
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
