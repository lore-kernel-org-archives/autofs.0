From: "Hamilton, Ian" <Ian.Hamilton@xerox.com>
Subject: Cross compiling autofs tools
Date: Mon, 12 Dec 2005 12:00:47 -0000
Message-ID: <DAF42D2FFC65A146BAB240719E4AD214D360E8@gbrwgceumf02.eu.xerox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi there.

I would like to add the automounter to an embedded MIPS system that I am
cross compiling on an x86 host. I've enabled autofs version 4 support in
the kernel, but I think I need the autofs user space tools as well.

I cannot find much information on cross-compiling the automount tools.
The usual cross-compiling options for configure don't seem to work, and
I'm not sure how to deal with the location of the system binaries.

Is there a Howto on cross-compiling autofs?

Cheers,
Ian.
