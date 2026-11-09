SELECT
                    vtiger_account.accountname                             AS 'empresa',
                    COALESCE(agr.groupname, aur.userlabel)               AS 'Agenda Responsável',
                    auc.userlabel                                        AS 'responsavel',
                    vtiger_activity.subject                              AS 'assunto',
                    CAST(vtiger_crmentitycalendar.createdtime AS date)  AS 'data criacao',
                    vtiger_activity.date_start                           AS 'data inicio',
                    CAST(vtiger_account.data_do_ultimo_agendamento AS date) AS 'dt alteracao',
                    CAST(vtiger_account.data_do_ultimo_agendamento AS time) AS 'hr alteracao',        
                    vtiger_account.accountstatus                         AS 'campo alterado',
                    vtiger_activity.status                               AS 'valor anterior',
                    vtiger_activity.eventstatus                          AS 'novo valor',
                    vtiger_accountscf.cf_779                             AS 'cf 779',
                    vtiger_account.rating                                AS 'Org',
                    vtiger_account.account_no                            AS 'account no'
                FROM nutriplant.vtiger_account
                INNER JOIN vtiger_crmentity ON vtiger_crmentity.crmid = vtiger_account.accountid
                LEFT JOIN vtiger_accountscf ON vtiger_account.accountid = vtiger_accountscf.accountid
                INNER JOIN vtiger_seactivityrel ON vtiger_seactivityrel.crmid = vtiger_account.accountid
                INNER JOIN vtiger_activity ON vtiger_activity.activityid = vtiger_seactivityrel.activityid AND vtiger_activity.activitytype != 'Emails'
                INNER JOIN vtiger_activitycf ON vtiger_activitycf.activityid = vtiger_activity.activityid
                INNER JOIN vtiger_crmentity vtiger_crmentitycalendar ON vtiger_crmentitycalendar.crmid = vtiger_activity.activityid AND vtiger_crmentitycalendar.deleted = 0 AND vtiger_crmentitycalendar.setype = 'Calendar'
                LEFT JOIN vtiger_users users2 ON vtiger_crmentity.smcreatorid = users2.id
                INNER JOIN vtiger_users auc ON auc.id = vtiger_crmentitycalendar.smcreatorid
                LEFT JOIN vtiger_users aur ON aur.id = vtiger_crmentitycalendar.smownerid
                LEFT JOIN vtiger_groups agr ON agr.groupid = vtiger_crmentitycalendar.smownerid