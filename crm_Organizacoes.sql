SELECT 
                    vtiger_account.accountname                     AS 'Nome Organização',
                    vtiger_account.account_no                      AS 'Código Organização',
                    vtiger_accountscf.cf_757                       AS 'Nome Abreviado',
                    vtiger_accountscf.cf_2490                      AS 'Alteração Classificação',
                    vtiger_accountscf.cf_781                       AS 'Classificação',
                    vtiger_account.account_type                    AS 'Tipo',
                    us.userlabel                                   AS 'Última Modificação por',
                    ua.userlabel                                   AS 'Responsável',
                    vtiger_account.data_do_ultimo_agendamento      AS 'Data Ultimo Agendamento',
                    vtiger_account.data_ult_cot_enviada            AS 'Data Ultima Cotação',
                    createdtime                                    AS 'Data/Hora Criação',
                    vtiger_accountscf.cf_759                       AS 'Código Cliente',
                    vtiger_account.cpfcnpj                         AS 'CPF/CNPJ',
                    vtiger_account.accountstatus                   AS 'Status Organização',
                    vtiger_account.razao_social_cnpj               AS 'Razão Social CNPJ',
                    vtiger_account.situacao_cadastral_cnpj         AS 'Situação Cadastral CNPJ',
                    vtiger_account.data_situacao_cadastral_cnpj    AS 'Data Situação Cadastral CNPJ',
                    vtiger_accountscf.cf_2564                      AS 'Ciclo de cotação',
                    vtiger_accountscf.cf_2557                      AS 'Dias Último Agendamento',
                    vtiger_accountscf.cf_779                       AS 'Segmento',
                    ut.userlabel                                   AS 'Responsável Conversão',
                    vtiger_accountscf.cf_2813                      AS 'Fonte Lead/Organização',
                    vtiger_accountbillads.bill_state               AS 'Estado1'


                FROM vtiger_account
                INNER JOIN vtiger_accountscf ON vtiger_accountscf.accountid = vtiger_account.accountid
                INNER JOIN vtiger_crmentity ca ON ca.crmid = vtiger_account.accountid 
                LEFT JOIN vtiger_accountbillads ON vtiger_accountbillads.accountaddressid = vtiger_account.accountid
                LEFT JOIN vtiger_users ua ON ua.id = ca.smownerid
                LEFT JOIN vtiger_users us ON us.id = ca.modifiedby
                LEFT JOIN vtiger_users ut ON ut.id = vtiger_account.responsavel_ultimo_agendamento_id
                LEFT JOIN vtiger_groups ga ON ga.groupid = ca.smownerid