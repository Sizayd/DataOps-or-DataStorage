# TP1 — Questions de compréhension : réponses

**Étudiant :** Zayd ZAYANI

1. **À quoi sert Azurite ?**
   Azurite sert à simuler les services de stockage Azure en local (Blob Storage, Queue Storage et Table Storage). Il permet aux développeurs de tester leurs applications sans utiliser directement le cloud Azure.

2. **Quelle est la différence entre Azurite et Azure réel ?**
   Azurite fonctionne localement sur le PC du développeur alors qu'Azure réel fonctionne dans le cloud Microsoft. Azurite est utilisé pour le développement et les tests, tandis qu'Azure réel est utilisé en production avec des fonctionnalités complètes comme la sécurité avancée, la haute disponibilité et la scalabilité.

3. **Pourquoi utiliser un container raw ?**
   Un container "raw" sert à stocker les fichiers bruts d'origine avant traitement. Cela permet de conserver une copie intacte des données importées pour les analyses, les vérifications ou les retraitements futurs.

4. **Pourquoi organiser les blobs par date ?**
   Organiser les blobs par date facilite la recherche des fichiers, le suivi chronologique des données, l'archivage et la maintenance du stockage. Cela améliore aussi les performances et l'organisation globale du système.

5. **Pourquoi historiser les fichiers ?**
   Historiser les fichiers permet de conserver les anciennes versions des données. Cela est utile pour revenir à une version précédente, suivre les modifications, assurer la traçabilité et éviter la perte de données importantes.

6. **Intérêt pédagogique d'Azurite ?**
   Azurite est très utile en formation car il permet de comprendre le fonctionnement d'Azure Storage sans cloud réel, de pratiquer les API Blob/Queue/Table, de simuler des architectures cloud complètes en local et d'apprendre sans coût ni configuration complexe Azure.
