# GUI Shader

Rectangle clip shader/mask for scrollable GUI containers.

Used for clipping container children.
This is not a generic (stencil) solution, since it works with rectangles only.

Parent sprite, as well as each child sprites should have this shader on.
Rectangular input values on each sprite should be set in sync with the parent.
This gives the effect of children being clipped by the parent.

This should be implemented recursively for containers within other containers.

## :tv: Video

https://www.youtube.com/watch?v=K0f2Nj0DPso

## :rocket: More

When having a sprite that is a child of another masking sprite, all you have to do is to "push down" the
masking information from a parent to the child, and saving it as child sprite's actual mask.

Furthermore, when having a sprite having multiple masking sprites up in the hierarchy, the actual mask is
the INTERSECTION of all the masks up in the hierarchy (in their global coordinates, as observed by the
orthographic camera). So the actual mask on each descendant sprite is the result of the AND operation of
all the masks up in the hierarchy (pixel-by-pixel).

Whenever the user changes the mask on a parent, the system should go through each ancestor, look for
SpriteRenderer components on each child and refresh their actual masks as described.

As an additional performance optimization, a kind of the "commit" command could be available on the
parent, so the user could commit the change for the part of the hierarchy - but only when finished changing
all the parent masks. This would then avoid the repetition of the process without a real purpose.

An interesting case happens when dealing with only rectangular masks: the resulting actual masks
(intersections) of the child sprites are also rectangular. It's just like looking through multiple (stacked)
windows, having random offset in X and Y direction.