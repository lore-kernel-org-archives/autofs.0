From: Ian Kent <raven@themaw.net>
Subject: Re: Cross compiling autofs tools
Date: Mon, 12 Dec 2005 22:18:08 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512122213450.5491@donald.themaw.net>
References: <DAF42D2FFC65A146BAB240719E4AD214D360E8@gbrwgceumf02.eu.xerox.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <DAF42D2FFC65A146BAB240719E4AD214D360E8@gbrwgceumf02.eu.xerox.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc: autofs@linux.kernel.org

On Mon, 12 Dec 2005, Hamilton, Ian wrote:

> Hi there.
> 
> I would like to add the automounter to an embedded MIPS system that I am
> cross compiling on an x86 host. I've enabled autofs version 4 support in
> the kernel, but I think I need the autofs user space tools as well.

Yes you will need autofs user space.

> 
> I cannot find much information on cross-compiling the automount tools.
> The usual cross-compiling options for configure don't seem to work, and
> I'm not sure how to deal with the location of the system binaries.

Location of the binaries is set at compile time for the location of the 
modules for reading maps, parsing and mounting. See the Makefile in the 
subdirectory "modules" in the source distribution.

> 
> Is there a Howto on cross-compiling autofs?

Not done that before and not having been involved with embeded systems I'm 
not sure how to go about it.

Maybe I could help you along and you could feed back your results.

Ian
