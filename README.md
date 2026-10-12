# Studio Notes — Carnet de photographe

Une application web responsive en français pour organiser les shootings cosplay, les contacts, les autorisations de tag/publication et les archives.

## Fonctionnalités présentes
- Création, modification et archivage d'événements.
- Un événement actif conservé quand on ferme puis rouvre le navigateur.
- Contacts avec pseudo, URL Instagram, cosplay, événement associé, notes, statut photo et autorisations.
- Recherche de contacts et filtres par événement.
- Export et import JSON.
- Manifest PWA et cache d'une coquille hors ligne.
- Déploiement automatisé via GitHub Actions / GitHub Pages.

## Mise en ligne
Le workflow `.github/workflows/pages.yml` publie le site sur GitHub Pages après un push sur `main`. Dans GitHub, ouvre **Settings → Pages** et vérifie que la source de déploiement est **GitHub Actions**. Puis ouvre **Actions** pour suivre le premier déploiement. L'adresse attendue est `https://tterminalboy-bot.github.io/carnet-photographe/`, une fois le déploiement réussi.

## Important : stockage et synchronisation
Cette première version stocke les données dans le navigateur avec `localStorage`. Les données ne se synchronisent donc pas automatiquement entre le PC et le téléphone et peuvent disparaître si les données du navigateur sont effacées. Utilise régulièrement l'export JSON. Une base distante avec authentification et règles d'accès doit être configurée avant d'ajouter la synchronisation multi-appareils. Ne mets jamais une clé secrète de serveur dans le code frontend.

## Confidentialité
Les liens Instagram sont simplement enregistrés et ouverts dans un nouvel onglet. L'application ne se connecte pas à l'API Instagram et ne récupère pas automatiquement les photos de profil. Les champs d'autorisation servent de suivi personnel ; ils ne remplacent pas le consentement explicite des personnes photographiées.