From: Ian Kent <raven@themaw.net>
Subject: Re: Automounts not working
Date: Fri, 15 Sep 2006 13:37:22 +0800
Message-ID: <1158298642.2953.1.camel@raven.themaw.net>
References: <57BFD82EEF0CDE41A72C4EDADF8A01B2031382B5@exchange27.fed.cclrc.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <57BFD82EEF0CDE41A72C4EDADF8A01B2031382B5@exchange27.fed.cclrc.ac.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Brine, KR (Keith)" <K.R.Brine@rl.ac.uk>
Cc: autofs@linux.kernel.org, redhat-list@redhat.com

On Wed, 2006-09-13 at 12:13 +0100, Brine, KR (Keith) wrote:
> Did you get a fix for "Automounts not working"

What?

> 
> I have the same errors... it only started recently (may be since
> upgrading Red Hat)

What versions?

> I am using: Linux #1 SMP Wed Jul 12 23:32:02 EDT 2006 x86_64 GNU/Linux
> I had been pulling my automount maps from my Sun NIS+ server running
> Solaris 7... worked fine.

What versions were working?

> 
> I now have a work around .... reconstructed the automount files in /etc
> auto.master and auto.another (referred to by auto.master).
> Had to change the /etc/nsswitch.conf file from "automount: files nis" to
> just "automount: files".
> The errors I get when trying to use NIS+ tables are :
> 
> Starting automount: do_ypcall: clnt_call: RPC: Procedure unavailable
> do_ypcall: clnt_call: RPC: Procedure unavailable
> do_ypcall: clnt_call: RPC: Procedure unavailable
> do_ypcall: clnt_call: RPC: Procedure unavailable
> do_ypcall: clnt_call: RPC: Procedure unavailable
> do_ypcall: clnt_call: RPC: Procedure unavailable
> No Mountpoints Defined                                     [  OK  ]
> 
>  
> Keith Brine 
> ISIS PEG Group, R2 2.07 
> Rutherford Appleton Laboratory 
> (01235 44 5499 
> Keith.Brine@rl.ac.uk 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
