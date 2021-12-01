# RubyMkvToolNix

RubyMkvToolNix is a work in-progress wrapper for [MkvToolNix](https://mkvtoolnix.download/) 

Currently the following modules are implemented (fully):
* [mkvpropedit](https://mkvtoolnix.download/doc/mkvpropedit.html)
* [mkvextract](https://mkvtoolnix.download/doc/mkvextract.html)

Partly implemented (aka just started :p, this one is pretty complex, and I am still thinking about how to make it as simple as possible without sacrificing functionality)
* [mkvmerge](https://mkvtoolnix.download/doc/mkvmerge.html)

## Installation

from [rubygems](https://rubygems.org/gems/mkvtoolnix)

```shell
gem 'mkvtoolnix'
```
or from the sources using
```shell
gem build mkvtoolnix.gemspec
```
and then execute
```shell
gem install mkvtoolnix-x.x.x.gem
```

## Usage

### Create MkvToolNix 

To use the modules, the toolset must be initialized first, to do so, just provide the path to the `bin` folder, e.g. 
`/users/thats_me/mkvtoolnix/bin/` or you installed `mkvtoolnix` e.g. using [Homebrew](https://formulae.brew.sh/formula/mkvtoolnix) and have it available in your PATH, means you can
execute the following command 
```shell
$ mkvextract -V
```
without getting an error, then you don't need to provide a path to the `bin` folder at all. Initialize  the toolset using
```ruby
mkv = MkvToolNix.init
```
with no binary path or
```ruby
mkv = MkvToolNix.mkv_bin_path('/users/thats_me/mkvtoolnix/bin/')
```
if you need to provide a binary path. 

Optionally, you can also pass some more flags:
* `abort_at_warning` - (default: `false`) which stops the process at the first warning (otherwise warnings will be ignored)
* `disable_language_ietf` - (default: `false`) per default, if the `language` property in `mkvpropedit` will be set, the field `language_ietf` will be updated automatically. If this is disabled, the `language_ietf` field will not be touched.

To set an additional option, just chain it together when initializing:
```ruby
mkv = MkvToolNix.mkv_bin_path('/users/thats_me/mkvtoolnix/bin/').abort_at_warning.disable_language_ietf
```

To get a specific module, such as `mkvpropedit` or `mkvextract`, just use the available reader:
```ruby
extract = mkv.mkvextract
propedit = mkv.mkvpropedit
merge = mkv.mkvmerge # currently not implemented
```

to analyze a file, the `mkvmerge` can be used, or to shorten it, the `info(file)` is also available in the `mkv` instance itself
```ruby
container_info = mkv.info('myFile.mkv')
# => biiiig instance with lot of information
# #<MkvToolNix::Types::Info::MkvContainer:0x000000014dbf9278
# @attachments=[#<MkvToolNix::Types::Info::Attachment:0x000000014dbf97c8 @content_type="jpeg/jpg", @description="--update-attachment", @file_name="new name", @id=1, @size_in_b=26457, @uid=12345>],
#  @audios=
#    [#<MkvToolNix::Types::Info::Audio:0x000000014dbf9368
#      @bit_depth=nil,
#      @channels=2,
#      @codec="E-AC-3",
#      ...
#    ],
#  @container_type=17,
#  @file_name="myFile.mkv",
#  @type="Matroska",
#  ...,
#  @videos=
#    [#<MkvToolNix::Types::Info::Video:0x000000014dbf9688
#      @codec="AVC/H.264/MPEG-4p10",
#      @codec_id="V_MPEG4/ISO/AVC",
#      @stereo_mode=nil,
#      @track_number=1,
#      @uid=219622901820485794>,
#      ...],
#  ...
```

### mkvpropedit

Is used to modify mkv properties. Per default, this will only take the available metadata and modifies them. Optionally,
a full parse can be performed instead of using the existing metadata. This can be done by setting the `full_parse_mode` flag to true, which is
present for each method. But take care, this can take several minutes, and should only be done if really necessary, e.g. if  the
existing metadata are broken.

All properties can be found in `MkvToolNix::Types::PropEdit::InfoProperty`, `MkvToolNix::Types::PropEdit::VideoProperty`, 
`MkvToolNix::Types::PropEdit::AudioProperty` and `MkvToolNix::Types::PropEdit::SubtitleProperty`.

Also note, a `Track` can either be a `video`, `audio` or `subtitle`.

#### available commands
* version
* delete_track_statistics_tags
* add_track_statistics_tags
* set_chapters
* set_tags
* remove_property
* set_property (add or update)
* remove_attachment
* replace_attachment
* add_attachment
* update_attachment

#### Selectors

Some methods like setting a tag or property, or removing one require a selector. The action will be performed on each element that matches
the selector. All selectors are described [here](https://mkvtoolnix.download/doc/mkvpropedit.html#mkvpropedit.edit_selectors). To simplify this,
the Module `MkvToolNix::PropEditSelector` offers several methods:
* `info` (fields such as the `title`)
* `for_nth_track` - the nth track, with n > 0, e.g. 1 is usually the video track)
* `for_nth_video` - the nth video track, with n > 0
* `for_nth_audio` - the nth audio track, with n > 0
* `for_nth_subtitle` - the nth subtitle track, with n > 0
* `by_track_number` - the track number can be found by using the `info(file)` method which returns the analyzed `mkv_container`. Each track has a field `track_number`. Alternatively `mkvmerge file.mkv --identify` can be used.
* `by_track_uid` - using the `uid` of each track 
* `for_attachment_by_id` - by providing the attachments `id`
* `for_attachment_by_name` - by providing the attachments `name`
* `for_attachment_by_mime_type` - by providing the attachments `mime-type`
* `tag_all` - to write to all tag fields
* `tag_global` - only write to global ones (so not for tracks)

#### Examples

##### Set Tags

```ruby
set_tags('myFile.mkv', 'myTagsFile.xml')
# => nil, or an error if something goes wrong
```
Updates the tags of the file with the tags of `MyTagsFile.xml`

##### Remove Property
```ruby
remove_property('myFile.mkv', MkvToolNix::PropEditSelector.for_nth_track(1), 'name')
# => nil, or an error if something goes wrong
```
removes the `name` property of the first track, which is usually the video track. As seen, the provided property is just a 
`String`. If the property is invalid, an error will be raised. If the property is passed as a `String`, it will be automatically
mapped to a Property. Alternatively, the Property can already be provided:
```ruby
remove_property('myFile.mkv', MkvToolNix::PropEditSelector.for_nth_track(1), MkvToolNix::Types::PropEdit::VideoProperty::NAME)
# => nil, or an error if something goes wrong
```

##### Remove Attachment

```ruby
remove_attachment('myFile,mkv', MkvToolNix::PropEditSelector.for_attachment_by_name('RemoveDatAttachment'))
# => nil, or an error if something goes wrong
```
This will remove all attachments with the name `RemoveDatAttachment`. Note, if there are multiple attachments that matches the selector, all of them
will be removed.

### mkvextract

extracts specific parts of MKV files.

#### available commands
* version
* extract_tracks
* extract_attachments
* extract_chapters
* extract_tags
* extract_cue_sheet
* extract_timestamps
* extract_cues

#### Tracks/Attachments list

methods such as `extract_attachments` or `extract_tracks` can extract multiple entries at once. For this, a list of elements to export can be provided. 
To simplify the process, this list can be given in several ways. The `MkvToolNix::Types::Extract::Track/Attachment` type can be used, a hash, just a string or array can be provided.
In general, the Track/Attachment ID and an output file is required for each entry.
* `Type`: just provide the ID and the output file in the defined `new(id, output_file)` constructor
* `Hash`: provide a hash of the form `{ id: [the id], output_file: [the output file]}` 
* `String`: just give the `output_file`, the id will be determined by the position of the string in the array
* `Array`: by providing a 2 elment array of the form `[id, output_file]`

For example the input `[Track.new(0, 'file0'), { id: 1, output_file: 'file1' }, 'file2', [3, 'file3']]`
will be converted to `[Track.new(0, 'file0'), Track.new(1, 'file1'), Track.new(2, 'file2'), Track.new(3, 'file3')]`

#### Examples

##### extract Tags
```ruby
extract_tags('myFile.mkv', 'exported_tags.xml')
# => nil, or an error if something goes wrong
```
will export the Tags from the file to `exported_tags.xml`. 
Note, that the file will only be created, if Tags exist.

##### extract Tracks

```ruby
extract_tracks(`myFile.mkv`, [Track.new(0, 'video.h264'), Track.new(2, 'german.eac3')])
# => nil, or an error if something goes wrong
```
will extract the video track at ID 0 to file `video.h264` and the audio track at ID 2 to file `german.eac3`.
Note that ID 1 could be another audio track, e.g. for english.

##### extract Attachments

```ruby
extract_attachments('myFile.mkv', [Attachment.new(0, 'attachment1.jpeg'), 'attachment2.png'])
# => nil, or an error if something goes wrong
```
will extract the attachments of the given file with ID 0 to `attachment1.jpeg` and ID 2 to `attachment.2.png`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cfe86/mkvtoolnix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/cfe86/mkvtoolnix/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mkvtoolnix project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cfe86/RubyMkvToolNix/blob/master/CODE_OF_CONDUCT.md).
