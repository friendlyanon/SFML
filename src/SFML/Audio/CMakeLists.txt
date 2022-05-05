sfml_add_library(Audio)

sfml_define_src_inc_variables()

sfml_target_sources(
    sfml-audio GROUP "" FILES
    ${src}/ALCheck.cpp
    ${src}/ALCheck.hpp
    ${src}/AlResource.cpp
    ${inc}/AlResource.hpp
    ${src}/AudioDevice.cpp
    ${src}/AudioDevice.hpp
    ${inc}/Export.hpp
    ${src}/Listener.cpp
    ${inc}/Listener.hpp
    ${src}/Music.cpp
    ${inc}/Music.hpp
    ${src}/Sound.cpp
    ${inc}/Sound.hpp
    ${src}/SoundBuffer.cpp
    ${inc}/SoundBuffer.hpp
    ${src}/SoundBufferRecorder.cpp
    ${inc}/SoundBufferRecorder.hpp
    ${src}/InputSoundFile.cpp
    ${inc}/InputSoundFile.hpp
    ${src}/OutputSoundFile.cpp
    ${inc}/OutputSoundFile.hpp
    ${src}/SoundRecorder.cpp
    ${inc}/SoundRecorder.hpp
    ${src}/SoundSource.cpp
    ${inc}/SoundSource.hpp
    ${src}/SoundStream.cpp
    ${inc}/SoundStream.hpp
)

sfml_target_sources(
    sfml-audio GROUP codecs FILES
    ${src}/SoundFileFactory.cpp
    ${inc}/SoundFileFactory.hpp
    ${inc}/SoundFileFactory.inl
    ${inc}/SoundFileReader.hpp
    ${src}/SoundFileReaderFlac.hpp
    ${src}/SoundFileReaderFlac.cpp
    ${src}/SoundFileReaderMp3.hpp
    ${src}/SoundFileReaderMp3.cpp
    ${src}/SoundFileReaderOgg.hpp
    ${src}/SoundFileReaderOgg.cpp
    ${src}/SoundFileReaderWav.hpp
    ${src}/SoundFileReaderWav.cpp
    ${inc}/SoundFileWriter.hpp
    ${src}/SoundFileWriterFlac.hpp
    ${src}/SoundFileWriterFlac.cpp
    ${src}/SoundFileWriterOgg.hpp
    ${src}/SoundFileWriterOgg.cpp
    ${src}/SoundFileWriterWav.hpp
    ${src}/SoundFileWriterWav.cpp
)

target_link_libraries(sfml-audio PUBLIC SFML::System)

# OpenAL: OpenAL Soft implementation supports clients using CMake via a config script since 1.21.0, but only supports the version argument since 1.22.0
find_package(FLAC REQUIRED)
find_package(OpenAL REQUIRED CONFIG)
find_package(Vorbis REQUIRED)
target_link_libraries(sfml-audio PRIVATE FLAC::FLAC Vorbis::vorbisenc Vorbis::vorbisfile OpenAL::OpenAL)

sfml_find_path_required(MINIMP3_INCLUDE_DIR minimp3.h PATH_SUFFIXES minimp3)
target_include_directories(sfml-audio SYSTEM PRIVATE "${MINIMP3_INCLUDE_DIR}")

if(SFML_OS_ANDROID)
    # android and OpenSLES: provided by the system
    target_link_libraries(sfml-audio PRIVATE android OpenSLES)
endif()
