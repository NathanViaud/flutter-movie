# Projet Flutter Movie

## Auteurs

- Nathan Viaud
- Julien Clerc

## Fonctionnalités

- Séries les plus populaires
- Recherche
- Profil
- Stockage des épisodes regardés (SQFlite)

## Développement

### Téléchargement des dépendances
```shell
flutter pub get
```

### Lancement de l'application
```shell
flutter run
```

## Architecture du projet
Dans le projet, nous avons utilisé l'architecture MVVM pour séparer les responsabilités entre les vues, les modèles de données et les vues modèles.

Dans le dossier `models`, nous avons défini les classes qui représentent les données de l'application.
Dans le dossier `views`, nous avons défini les widgets qui composent l'interface utilisateur de l'application.
Dans le dossier `services`, nous avons défini les classes qui gèrent les interactions avec les API externes.
Dans le dossier `viewmodels`, nous avons défini les classes qui gèrent les interactions entre les vues et les modèles de données.
