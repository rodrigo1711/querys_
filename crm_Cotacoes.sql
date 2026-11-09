SELECT 
                    q.quote_no AS `nro cotacao`,
                    vtiger_accountscf.cf_759 AS `Código`,
                    a.accountname AS `empresa`,
                    u.first_name AS `first name`,
                    u.last_name AS `last name`,
                    q.subject AS `assunto`,
                    p.productcode AS `Cod. Item`,
                    COALESCE(s.servicename, p.productname) AS `produto`,
                    q.quotestage AS `estagio`,
                    cf.cf_859 AS `Motivo`,
                    q.motivo_desc_perda AS `Desc Motivo Perda`,
                    DATE(c.createdtime) AS `data_criacao`,
                    c.modifiedtime AS `Data Modificação`,
                    cur.currency_symbol AS `moeda`,
                    i.listprice AS `Preço`,
                    i.listprice * i.quantity AS `Total Item`,
                    i.quantity AS `Quantidade`,
                    q.total AS `Total`,
                    i.tax2 AS `ICMS`,
                    i.tax3 AS `PIS`,
                    i.tax4 AS `COFINS`,
                    pt.potential_no AS `Nº oport`,
                    a.account_no AS `account_no`
                FROM vtiger_quotes q
                INNER JOIN vtiger_crmentity c ON c.crmid = q.quoteid AND c.deleted = 0
                INNER JOIN vtiger_quotescf cf ON cf.quoteid = q.quoteid
                INNER JOIN vtiger_currency_info cur ON cur.id = q.currency_id
                INNER JOIN vtiger_inventoryproductrel i ON i.id = q.quoteid
                LEFT JOIN vtiger_potential pt ON pt.potentialid = q.potentialid
                LEFT JOIN vtiger_products p ON p.productid = i.productid
                LEFT JOIN vtiger_service s ON s.serviceid = i.productid
                LEFT JOIN vtiger_account a ON a.accountid = q.accountid
                INNER JOIN vtiger_accountscf ON vtiger_accountscf.accountid = a.accountid
                LEFT JOIN vtiger_users u ON u.id = c.smownerid
                LEFT JOIN vtiger_groups g ON g.groupid = c.smownerid