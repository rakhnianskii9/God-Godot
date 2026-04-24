# Properties

Properties form the attributes or details of entities, allowing them to be distinct and varied. In Pandora, properties are a modular unit, designed for maximum flexibility and reusability.

## Overview

- **Modularity**: Properties in Pandora are distinct from categories and entities in terms of their modeling. This design choice ensures that properties can be reused across different entities without redundancy.

- **Default Value**: By design, each property has a 'default value'. This captures the entity's original, unaltered state. To modify these values during gameplay, instances of entities are created. For a deeper dive into this process, see [Entity Instancing](../../api/instancing.md).

- **Unique Identification**: Every property is uniquely identifiable by an **ID**. Additionally, they have a name, or key, which is paired with a `Variant` default value. This ensures clear identification and access.

- **Types of Properties**: The power of Pandora lies in its flexibility. It supports a wide array of property types, enabling developers to define virtually any aspect of their game world.

Getting acquainted with how properties function in Pandora is crucial to defining detailed and rich game entities.

## Supported Properties

The following property types are supported:

|Pandora Type|Godot Type|
|---|---|
|[String](string.md)|`String`|
|[Integer](integer.md)|`int`|
|[Float](float.md)|`float`|
|[Bool](bool.md)|`bool`|
|[Vector2i](vector2i.md)|`Vector2i`|
|[Vector2](vector2.md)|`Vector2`|
|[Vector3i](vector3i.md)|`Vector3i`|
|[Vector3](vector3.md)|`Vector3`|
|[Color](color.md)|`Color`|
|[Reference](reference.md)|`PandoraEntity`|
|[Resource](resource.md)|`Resource`|
|[Array](array.md)|`Array`|

## Contribute

[Refer to this link](https://github.com/bitbrain/pandora/issues?q=is%3Aissue+label%3A%22%F0%9F%94%8C+property%22+is%3Aopen) for a complete list of open issues related to properties.
