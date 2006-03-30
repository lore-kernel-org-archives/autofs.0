From: Mi <mi.lists@alma.ch>
Subject: Re: Autofs wrongly tries to use NFS for a program map
Date: Thu, 30 Mar 2006 10:59:54 +0200
Message-ID: <442B9E0A.20701@alma.ch>
References: <442ACE3C.5020600@alma.ch>
	<x49hd5havoc.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49hd5havoc.fsf@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


> Program maps need not print the "key".  Since the automount daemon already
> knows what key it is looking up, this would be redundant information.
>   
Thanks a lot. Indeed, removing the key form the script output solved the 
problem.


May I suggest adding some details to the autofs.5 man page, in the 
"program" section? The output format expected from an executable map 
doesn't seem to be documented anywhere in the man pages.

I was just a bout to do it and submit a diff for autofs.5, but then I 
realized that I really don't know the format which is expected. For a 
normal map, it would seem to be

[options] :device

But what is the expected format for an NFS map, and what other formats 
can be used?


Thank you,

MI
