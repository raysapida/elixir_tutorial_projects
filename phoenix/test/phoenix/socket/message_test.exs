defmodule Phoenix.Socket.MessageTest do
  use ExUnit.Case, async: true

  alias Phoenix.Socket.Message
  alias Phoenix.Socket.Message.InvalidMessage

  test "parse! returns map when given valid json with required keys" do
    message = Message.parse!("""
    {"topic": "c","event":"e","payload":"m"}
    """)

    assert message.topic == "c"
    assert message.event == "e"
    assert message.payload == "m"
  end

  test "parse! raises Poison.SyntaxError when given invalid json" do
    assert_raise Poison.SyntaxError, fn ->
      Message.parse!("""
      {INVALID"topic": "c","event":"e","payload":"m"}
      """)
    end
  end

  test "parse! raises InvalidMessage when missing :topic key" do
    assert_raise InvalidMessage, fn ->
      Message.parse!("""
      {"event":"e","payload":"m"}
      """)
    end
  end

  test "parse! raises InvalidMessage when missing :event key" do
    assert_raise InvalidMessage, fn ->
      Message.parse!("""
      {"topic": "c","payload":"m"}
      """)
    end
  end

  test "parse! raises InvalidMessage when missing :payload key" do
    assert_raise InvalidMessage, fn ->
      Message.parse!("""
      {"topic": "c","event":"e"}
      """)
    end
  end

  test "from_map! converts a map with string keys into a %Message{}" do
    msg = Message.from_map!(%{"topic" => "c", "event" => "e", "payload" => ""})
    assert msg == %Message{topic: "c", event: "e", payload: ""}
  end

  test "from_map! raises InvalidMessage when any required key" do
    assert_raise InvalidMessage, fn ->
      Message.from_map!(%{"event" => "e", "payload" => ""})
    end
    assert_raise InvalidMessage, fn ->
      Message.from_map!(%{"topic" => "c", "payload" => ""})
    end
    assert_raise InvalidMessage, fn ->
      Message.from_map!(%{"topic" => "c", "event" => "e"})
    end
  end
end
