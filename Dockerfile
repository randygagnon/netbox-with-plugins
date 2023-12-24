FROM netboxcommunity/netbox:v3.6.7-2.7.0
LABEL org.opencontainers.image.source https://github.com/randygagnon/netbox-plugins 
LABEL org.opencontainers.image.description="Netbox Docker customized with Plugins"

# Install Python Packages
COPY ./plugin_requirements.txt /opt/netbox/
RUN /opt/netbox/venv/bin/pip install  --no-warn-script-location -r /opt/netbox/plugin_requirements.txt

# Build the custom image. These lines are only required if your plugin has its own static files.
# COPY configuration/configuration.py /etc/netbox/config/configuration.py
# COPY configuration/plugins.py /etc/netbox/config/plugins.py
RUN SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
