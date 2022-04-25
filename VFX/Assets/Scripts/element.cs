using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class element : MonoBehaviour
{
    public bool showVerts;
    public bool showNormals;

    Material mat;
    Mesh mesh;

    void Awake() {
        mesh = GetComponent<MeshFilter>().mesh;
        mat = new Material(Shader.Find("Unlit/VertColors"));
    }

    void Update() {
        transform.Rotate(0, 30 * Time.deltaTime, 0, Space.World);
    }

    void OnRenderObject() {
        var verts = mesh.vertices;
        var normals = mesh.normals;
        var tris = mesh.triangles;

        GL.PushMatrix();
        GL.MultMatrix(transform.localToWorldMatrix);

        GL.Begin(GL.LINES);
        mat.SetPass(0);

        if(showNormals) {
            GL.Color(Color.cyan);
            for(int i = 0; i < verts.Length; i++) {
                var end = verts[i] + normals[i] * 0.2f;
                GL.Vertex3(verts[i].x, verts[i].y, verts[i].z);
                GL.Vertex3(end.x, end.y, end.z);
            }
        }

        if(showVerts) {
            GL.Color(Color.black);
            for(int i = 0; i < tris.Length; i += 3) {
                var i1 = tris[i];
                var i2 = tris[i + 1];
                var i3 = tris[i + 2];

                var v1 = verts[i1] + normals[i1] * 0.001f;
                var v2 = verts[i2] + normals[i2] * 0.001f;
                var v3 = verts[i3] + normals[i3] * 0.001f;

                GL.Vertex3(v1.x, v1.y, v1.z);
                GL.Vertex3(v2.x, v2.y, v2.z);

                GL.Vertex3(v2.x, v2.y, v2.z);
                GL.Vertex3(v3.x, v3.y, v3.z);

                GL.Vertex3(v3.x, v3.y, v3.z);
                GL.Vertex3(v1.x, v1.y, v1.z);
            }
        }

        GL.End();
        GL.PopMatrix();
    }
}
