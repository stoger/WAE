# Basis-Image mit Perl
FROM perl:latest

# Installiere notwendige Perl-Module
RUN cpanm --notest Mason Plack

# Setze Arbeitsverzeichnis
WORKDIR /app

# Kopiere das gesamte Projekt in den Container
COPY . /app

# Installiere zusätzliche Abhängigkeiten (falls nötig)
RUN if [ -f cpanfile ]; then cpanm --installdeps .; fi

# Standardbefehl, um Plack zu starten
CMD ["plackup", "--host", "0.0.0.0", "--port", "5000", "app.psgi"]
