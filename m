From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: Autofs hang, centos 4.4
Date: Sat, 18 Nov 2006 17:43:31 -0800
Message-ID: <455FB6C3.8060801@soe.ucsc.edu>
References: <455C8BA8.9070609@soe.ucsc.edu>	
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>	
	<455CB5F6.9040201@soe.ucsc.edu>
	<1163749264.2993.67.camel@localhost>
	<1163872272.2973.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163872272.2973.5.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

>>> nisMapName: auto.master
>>> nisMapEntry: ldap:nisMapName=auto.projects,dc=kilokluster,dc=ucsc,dc=edu 
>>> -browse,hard,intr,rw
> 
> Umm.
> 
> Browsable map. It may be possible it's not catching Ctrl-C.
> 
> I'll check.
> 
> And the user shell is?

tcsh for normal users.  bash shell when root.  If it's an issue of me 
not using browsable maps I can turn that off, it's not crucial.  I'll 
test it.

Thanks for checking!

-erich
