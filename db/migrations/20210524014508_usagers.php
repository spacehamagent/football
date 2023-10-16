<?php

use Phinx\Migration\AbstractMigration;

class Usagers extends AbstractMigration {
    public function change() {
        $tableUsagers = $this->table('usagers', ['id' => false, 'primary_key' => 'noUsager']);
        
        $tableUsagers->addColumn('noUsager', 'integer')
            ->addColumn('prenomUsager', 'string')
            ->addColumn('nomUsager', 'string')
            ->addColumn('courrielUsager', 'string')
            ->addColumn('telephoneUsager', 'string')
            ->addColumn('cellulaireUsager', 'string')
            ->addColumn('motDePasseUsager', 'string')
            ->addColumn('actifUsager', 'integer')
            ->addColumn('adminUsager', 'integer')
            ->addColumn('noSexe', 'integer')
            ->addColumn('hashUsager', 'string')
            ->addColumn('dateNaissanceUsager', 'date')
            ->addColumn('dateConnexionUsager', 'datetime')
            ->create();

        $tableUsagersPages = $this->table('usagersPages', ['id' => false, 'primary_key' => ['noUsager','noPage']]);

        $tableUsagersPages->addColumn('noUsager', 'integer')
            ->addColumn('noPage', 'integer')
            ->addColumn('dateModifierUsagerPage', 'datetime')
            ->create();
    }
}
