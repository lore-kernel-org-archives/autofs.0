From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs wrongly tries to use NFS for a program map
Date: Thu, 30 Mar 2006 09:29:35 -0500
Message-ID: <x494q1gatv4.fsf@segfault.boston.redhat.com>
References: <442ACE3C.5020600@alma.ch>
	<x49hd5havoc.fsf@segfault.boston.redhat.com> <442B9E0A.20701@alma.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <442B9E0A.20701@alma.ch> (Mi's message of "Thu, 30 Mar 2006
	10:59:54 +0200")
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
Content-Transfer-Encoding: 7bit
To: Mi <mi.lists@alma.ch>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Autofs wrongly tries to use NFS for a program map; Mi <mi.lists@alma.ch> adds:

>> Program maps need not print the "key".  Since the automount daemon
>> already knows what key it is looking up, this would be redundant
>> information.
>> 
mi> Thanks a lot. Indeed, removing the key form the script output solved
mi> the problem.


mi> May I suggest adding some details to the autofs.5 man page, in the
mi> "program" section? The output format expected from an executable map
mi> doesn't seem to be documented anywhere in the man pages.

Yes, this is a good suggestion.

mi> I was just a bout to do it and submit a diff for autofs.5, but then I
mi> realized that I really don't know the format which is expected. For a
mi> normal map, it would seem to be

mi> [options] :device

mi> But what is the expected format for an NFS map, and what other formats
mi> can be used?

A program map uses the same syntax as a file map.  I think something like
the attached should be sufficient.

Thanks,

Jeff

--- autofs/man/autofs.5.orig	2006-03-30 09:23:45.000000000 -0500
+++ autofs/man/autofs.5	2006-03-30 09:27:38.000000000 -0500
@@ -153,7 +153,12 @@ map to the automounter.  A
 .B program
 map will be called as a script with the key as an argument.  It may
 return no lines of output if there's an error, or one or more lines
-containing a map (with \\ quoting line breaks).
+containing a map (with \\ quoting line breaks).  The output from the
+.B program
+map should omit the key;  aside from that, it supports exactly the
+same syntax as a
+.B file
+map.
 .P
 To use a 
 .B program
