using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class coin : MonoBehaviour
{

    private float rotationSpeed = 20f;

    void Start()
    {

    }

    void Update()
    {
        transform.Rotate(Vector3.up, Time.deltaTime * rotationSpeed);
    }

    void OnTriggerEnter(Collider other)
    {
        Debug.Log("Destroy coin");
        Destroy(gameObject);
    }
}
