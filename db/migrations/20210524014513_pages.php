<?php

use Phinx\Migration\AbstractMigration;

class Pages extends AbstractMigration {
    public function change() {
        $tablePages = $this->table('pages', ['id' => false, 'primary_key' => 'noPage']);
    
        $tablePages->addColumn('noPage', 'integer')
            ->addColumn('modulePage', 'string')
            ->addColumn('actifPage', 'integer')
            ->addColumn('dansLeMenuPage', 'integer')
            ->addColumn('micrositePage', 'integer')
            ->addColumn('pageParentPage', 'integer')
            ->addColumn('iconePage', 'string')
            ->addColumn('indexationSitePage', 'integer')
            ->addColumn('afficherDescriptionPage', 'integer')
            ->addColumn('niveauPage', 'integer')
            ->addColumn('positionPage', 'integer')
            ->addColumn('dateModificationPage', 'datetime')
            ->create();

        $tablePagesLangues = $this->table('pagesLangues', ['id' => false, 'primary_key' => ['noPage','noLangue']]);

        $tablePagesLangues->addColumn('noPage', 'integer')
            ->addColumn('noLangue', 'integer')
            ->addColumn('titrePageLangue', 'string')
            ->addColumn('repertoirePageLangue', 'integer')
            ->addColumn('descriptionPageLangue', 'text')
            ->addColumn('contenuBlocPageLangue', 'text')
            ->addColumn('titreIndexationPageLangue', 'string')
            ->addColumn('descriptionIndexationPageLangue', 'text')
            ->create();
    }
}
