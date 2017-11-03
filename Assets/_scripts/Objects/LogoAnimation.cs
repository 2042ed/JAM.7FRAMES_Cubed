using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using DG.Tweening;

public class LogoAnimation : MonoBehaviour
{
    public float DeltaYrotation = 2f;
    public float Duration = 2f;

    void Start()
    {
        var currentAngel = transform.rotation.eulerAngles.y;
        var rotA = new Vector3(0, currentAngel + DeltaYrotation, 0);
        var rotB = new Vector3(0, currentAngel - DeltaYrotation, 0);

        Sequence s = DOTween.Sequence();
        s.Append(transform.DORotate(rotA, Duration));
        s.Append(transform.DORotate(rotB, Duration));
        s.SetLoops(-1, LoopType.Yoyo);
    }
}
