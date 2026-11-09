SELECT
                CAST(vc.createdtime AS date) AS 'Data Criação',
                vld.lead_no AS 'Código Lead',
                vld.company AS 'Empresa',
                vc.createdtime AS 'Data/Hora Criação',
                vld.firstname AS 'Nome',
                vld.lastname AS 'Sobrenome',
                vld.cpfcnpj AS 'CPF/CNPJ',
                vld.leadsource AS 'Fonte Lead',
                vld.product AS 'Nome do produto',
                vld.email AS 'Email',
                va.subject AS 'Etapa Lead',
                vld.leadstatus AS 'Status Lead',
                vlcf.cf_2905 AS 'Campanha',
                aur.userlabel AS 'Responsavel',
                auc.userlabel AS 'Criado Por',
                vld.tags AS 'RD Tag'
            FROM
                vtiger_leaddetails AS vld
            INNER JOIN
                vtiger_crmentity AS vc ON vc.crmid = vld.leadid
            INNER JOIN
                vtiger_leadscf AS vlcf ON vld.leadid = vlcf.leadid
            INNER JOIN
                vtiger_seactivityrel AS vsar ON vsar.crmid = vld.leadid
            INNER JOIN
                vtiger_activity AS va ON va.activityid = vsar.activityid AND va.activitytype != 'Emails'
            INNER JOIN
                vtiger_activitycf AS vacf ON vacf.activityid = va.activityid
            INNER JOIN
                vtiger_crmentity AS vcc ON vcc.crmid = va.activityid
                AND vcc.deleted = 0
                AND vcc.setype = 'Calendar'
            INNER JOIN
                vtiger_users AS auc ON auc.id = vc.smcreatorid -- Criado Por
            LEFT JOIN
                vtiger_users AS aur ON aur.id = vcc.smownerid -- Responsável (da atividade/calendário)
            LEFT JOIN
                vtiger_groups AS agr ON agr.groupid = vcc.smownerid
            WHERE
                vld.leadid > 0
                AND vc.deleted = 0
                AND vld.converted = 0;