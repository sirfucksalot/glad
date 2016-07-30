module glad.{{ feature_set.api }}.loader;

private {
    import glad.{{ feature_set.api }}.functions;
    import glad.{{ feature_set.api }}.enumerations;
    import glad.{{ feature_set.api }}.types;
}


alias Loader = void* delegate(const(char)*);


{% include 'loader/' + spec.name + '.d' %}

private {
{% for extension in chain(feature_set.features, feature_set.extensions) %}
void load_{{ extension.name }}(Loader load) {
    {% set commands = extension.get_requirements(spec, feature_set.api, feature_set.profile).commands %}
    {% if commands %}
    if (!{{ extension.name }}) return;
    {% for command in commands %}
    {{ command.proto.name }} = cast(typeof({{ command.proto.name }}))load("{{ command.proto.name }}");
    {% endfor %}
    {% endif %}
}
{% endfor %}
}