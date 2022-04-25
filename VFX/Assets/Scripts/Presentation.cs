using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Presentation : MonoBehaviour
{
    public struct Slide {
        public bool showVerts;
        public bool showNormal;
        public bool showWhite;
        public bool showVertsColor;
        public bool showNormalsColor;
        public bool showNormalizedNormals;
        public bool showUv;
        public bool showTexture;
    }

    public element[] elements;

    List<Slide> slides = new List<Slide>();
    int currentSlideIndex;

    void Awake() {
        slides.Add(new Slide {
            showWhite = true,
        });
        
        slides.Add(new Slide {
            showWhite = true,
            showVerts = true,
        });

        slides.Add(new Slide {
            showVerts = true,
            showVertsColor = true,
        });

        slides.Add(new Slide {
            showWhite = true,
            showVerts = true,
            showNormal = true,
        });
        
        slides.Add(new Slide {
            showVerts = true,
            showNormalsColor = true,
        });
        
        slides.Add(new Slide {
            showVerts = true,
            showNormalizedNormals = true,
        });
        
        slides.Add(new Slide {
            showVerts = true,
            showUv = true,
        });
        
        slides.Add(new Slide {
            showVerts = true,
            showTexture = true,
        });

        SetSlide(slides[0]);
    }

    void Update() {
        if(Input.GetKeyDown(KeyCode.RightArrow)) {
            if(currentSlideIndex < slides.Count - 1) {
                currentSlideIndex += 1;
                SetSlide(slides[currentSlideIndex]);
            }
        }
        
        if(Input.GetKeyDown(KeyCode.LeftArrow)) {
            if(currentSlideIndex > 0) {
                currentSlideIndex -= 1;
                SetSlide(slides[currentSlideIndex]);
            }
        }
    }

    void SetSlide(Slide slide) {
        foreach(var el in elements) {
            el.showVerts = slide.showVerts;
            el.showNormals = slide.showNormal;
        }

        Shader.SetGlobalFloat("showWhite", slide.showWhite ? 1 : 0);
        Shader.SetGlobalFloat("vertColor", slide.showVertsColor ? 1 : 0);
        Shader.SetGlobalFloat("normals", slide.showNormalsColor ? 1 : 0);
        Shader.SetGlobalFloat("normalizedNormals", slide.showNormalizedNormals ? 1 : 0);
        Shader.SetGlobalFloat("uv", slide.showUv ? 1 : 0);
        Shader.SetGlobalFloat("tex", slide.showTexture ? 1 : 0);
    }
}
