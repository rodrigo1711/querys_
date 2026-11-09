SELECT
                    potential_no                   AS `Oportunidades No. Oportunidade`,
                    potentialname                  AS `Oportunidades Título Oportunidade`,
                    accountname                    AS `Oportunidades Nome Organização`,
                    sales_stage                    AS `Oportunidades Estágio Vendas`,
                    closingdate                    AS `Oportunidades Previsão Fechamento`,
                    amount                         AS `Oportunidades Valor Fechamento`,
                    vtiger_crmentity.smownerid     AS `Oportunidades Responsável`,
                    vtiger_crmentity.createdtime   AS `Oportunidades Data/Hora Criação`,
                    vtiger_crmentity.modifiedtime  AS `Oportunidades Data/Hora Modificação`,
                    vtiger_crmentity.smcreatorid   AS `Oportunidades Criado Por`,
                    potcf.cf_2858                  AS `Objetivo Oportunidade`,
                    account_no                     AS `Organizações Código Organização`,
                    vtiger_accountscf.cf_759       AS `Organizações Código Cliente`,
                    potcf.cf_795                   AS `Oportunidades Motivo Perda`
                FROM vtiger_potential pot
                LEFT JOIN vtiger_account acc ON pot.related_to = acc.accountid
                LEFT JOIN vtiger_users users ON acc.responsavel_ultimo_agendamento_id = users.id
                LEFT JOIN vtiger_potentialscf potcf ON pot.potentialid = potcf.potentialid
                LEFT JOIN vtiger_crmentity ON pot.potentialid = vtiger_crmentity.crmid
                LEFT JOIN vtiger_users users2 ON vtiger_crmentity.smcreatorid = users2.id
                LEFT JOIN vtiger_seactivityrel ON pot.potentialid = vtiger_seactivityrel.crmid
                LEFT JOIN vtiger_accountscf ON acc.accountid = vtiger_crmentity.smownerid
                LEFT JOIN vtiger_activity ON vtiger_seactivityrel.activityid = vtiger_activity.activityid