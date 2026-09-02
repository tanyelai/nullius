# 01 · Is a gap real, or did the search fail

**Subject.** Speculative decoding: draft-and-verify inference for language models.

**Task.** Decide whether *"nobody has characterised when speculative decoding hurts output
quality rather than only latency"* is an open question or a failed search.

**The point.** This is the use case where the tool's opinion matters most and where a naive
assistant is most confidently wrong. Silence is the expected reading of an empty result, and
silence is almost always the wrong reading.

## A healthy run

1. `start` an `idea` unit and `accept` a question that is open right now.
2. Three vocabularies: the user's own framing, the field's own term, and one adjacent area.
3. Screen, with a reason each. `kills` and `cost` recorded.
4. Close on what the search actually established.

## Must refuse

- Closing the unit with **no search logged**. Silence is a failed search.
- Closing with **every retrieved work screened out**. An empty neighbour set is a red flag.
- Closing with **no killing assumption** or **no cost estimate**.
- An acceptance answer with no locator.

## Must allow

- A neighbour set of one, if that one is genuinely the nearest work.
- Three vocabularies that return overlapping sets. Overlap is a finding, not an error.
- Closing with *the gap is not real*, which is a successful run, not a failed one.

## Failure signatures

- The tool blocks a unit that has done all four things.
- The tool permits a close with an empty neighbour set.
- A retrieved set is dominated by works unrelated to the subject.
