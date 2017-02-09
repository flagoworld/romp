/*
 
 Copyright (c) 2016, Mo DeJong
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 
 */

// Note that compiling a precision statement with Metal is not unsupported.
// It is possible to add the precision statememnt when only targeting OpenGL.

//precision mediump float;
precision highp float;

//uniform sampler2D u_texture;
//uniform vec2 outSampleHalfPixelOffset;
//uniform vec2 inSampleHalfPixelOffset;
//uniform vec2 tileSize;

void main(void)
{
    vec2 oneOutputPixel = outSampleHalfPixelOffset * 2.0;
    vec2 oneInputPixel = inSampleHalfPixelOffset * 2.0;
    
    // Convert normalized texture coord to whole number of render pixels
    
    vec2 outNumPixels = (v_tex_coord - outSampleHalfPixelOffset) / oneOutputPixel;
    outNumPixels = floor(outNumPixels + 0.5);
    
    // Convert whole number of render pixels to whole numer of sample pixels via mod() and round()
    
    vec2 modNumPixels = mod(outNumPixels, tileSize);
    modNumPixels = floor(modNumPixels + 0.5);
    
    vec2 lookupCoord = inSampleHalfPixelOffset + (modNumPixels * oneInputPixel);
    
    vec4 pix = texture2D(u_texture, lookupCoord);
    
    gl_FragColor = pix;
}
