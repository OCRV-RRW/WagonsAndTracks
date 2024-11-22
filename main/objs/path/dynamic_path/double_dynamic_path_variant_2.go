components {
  id: "dynamic_path"
  component: "/main/objs/path/dynamic_path/dynamic_path.script"
  properties {
    id: "type"
    value: "3.0"
    type: PROPERTY_TYPE_NUMBER
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"double_dynamic_path_variant_2_direction\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 200.0\n"
  "  y: 200.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/atlases/path.atlas\"\n"
  "}\n"
  ""
}
