
                SELECT
                    vtiger_leaddetails.company                                 AS 'empresa',
                    vtiger_leaddetails.firstname                              AS 'firstname',
                    vtiger_leaddetails.lastname                               AS 'lastname',
                    auc.userlabel                                              AS 'responsavel',
                    COALESCE(agr.groupname, aur.userlabel)                    AS 'alterado por',
                    vtiger_activity.subject                                   AS 'assunto',
                    CAST(vtiger_crmentitycalendar.createdtime AS date)       AS 'data criacao',
                    vtiger_activity.date_start                                AS 'data inicio',
                    CAST(vtiger_leaddetails.data_do_ultimo_agendamento AS date) AS 'dt alteracao',
                    CAST(vtiger_leaddetails.data_do_ultimo_agendamento AS time) AS 'hr alteracao',
                    vtiger_leaddetails.leadstatus                             AS 'campo alterado',
                    vtiger_activity.status                                    AS 'valor anterior',
                    vtiger_leaddetails.eventstatus                            AS 'novo valor',
                    vtiger_leadscf.cf_777                                     AS 'cf 777',
                    vtiger_leadscf.cf_2788                                    AS 'Leads',
                    vtiger_leaddetails.leadsource                             AS 'leadsource'
                FROM vtiger_leaddetails
                INNER JOIN vtiger_crmentity ON vtiger_crmentity.crmid = vtiger_leaddetails.leadid
                INNER JOIN vtiger_leadscf ON vtiger_leaddetails.leadid = vtiger_leadscf.leadid
                INNER JOIN vtiger_seactivityrel ON vtiger_seactivityrel.crmid = vtiger_leaddetails.leadid
                INNER JOIN vtiger_activity ON vtiger_activity.activityid = vtiger_seactivityrel.activityid AND vtiger_activity.activitytype != 'Emails'
                INNER JOIN vtiger_activitycf ON vtiger_activitycf.activityid = vtiger_activity.activityid
                INNER JOIN vtiger_crmentity vtiger_crmentitycalendar ON vtiger_crmentitycalendar.crmid = vtiger_activity.activityid AND vtiger_crmentitycalendar.deleted = 0 AND vtiger_crmentitycalendar.setype = 'Calendar'
                LEFT JOIN vtiger_groups ON vtiger_groups.groupid = vtiger_crmentitycalendar.smownerid
                LEFT JOIN vtiger_users ON vtiger_users.id = vtiger_crmentitycalendar.smownerid
                LEFT JOIN vtiger_groups AS vtiger_groupsleads ON vtiger_groupsleads.groupid = vtiger_crmentity.smownerid
                LEFT JOIN vtiger_users AS vtiger_usersleads ON vtiger_usersleads.id = vtiger_crmentity.smownerid
                INNER JOIN vtiger_users auc ON auc.id = vtiger_crmentitycalendar.smcreatorid
                LEFT JOIN vtiger_users aur ON aur.id = vtiger_crmentitycalendar.smownerid
                LEFT JOIN vtiger_groups agr ON agr.groupid = vtiger_crmentitycalendar.smownerid
                WHERE vtiger_leaddetails.leadid > 0 
                  AND vtiger_crmentity.deleted = 0  
                  AND vtiger_leaddetails.converted = 0