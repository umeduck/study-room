module RoomCreateSupport
  def room_create(room)
    visit new_room_path
    fill_in 'ルーム名', with: room.title
    click_on ('ルームを作成する')
    expect(current_path).to eq(root_path)
  end
end