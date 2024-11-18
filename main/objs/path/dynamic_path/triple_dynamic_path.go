components {
  id: "dynamic_path1"
  component: "/main/objs/path/dynamic_path/dynamic_path.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"triple_dynamic_path_forward_cell\"\n"
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
