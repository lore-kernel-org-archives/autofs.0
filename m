From: "Chris Croswhite" <csc@cadence.com>
Subject: RE: Autofs picking first server from the automounter map
	all the time
Date: Sun, 2 May 2004 11:00:11 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <EE335453C5C57840823404C684F9F61702417749@exmbx01sj.cadence.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net, Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org, "Patel, Rahulkumar [NJ]" <rahul@lehman.com>

I will help test if you could point the location of the patches.




-----Original Message-----
From:	raven@themaw.net [mailto:raven@themaw.net]
Sent:	Sun 02-May-04 07:01
To:	Michael Blandford
Cc:	'autofs@linux.kernel.org'; Patel, Rahulkumar [NJ]
Subject:	Re: [autofs]  Autofs picking first server from the automounter map all the time

On Fri, 30 Apr 2004, Michael Blandford wrote:

> Patel, Rahulkumar [NJ] wrote:
> 
> >Hi,
> >I have following entry defined in the automounter map.
> >But, when I try to access it all the time it pick last server defined for
> >that mount.
> >
> >perl -ro,soft,nosuid,noquota,intr server1:/vol/vol1/software/perl
> >server2:/vol/vol1/software/perl.
> >
> >
> >When I cd /home/perl --> All the time I connect to server2.
> >
> >I am running autofs-3.1.7-21.
> >  
> >
> Autofs 3.x and autofs 4.0.x didn't have real support for replicated 
> server.  It simply picks the first server in the list.
> 
> Autofs 4.1.x does include support for replicated server.  You should 
> upgrade and test.
>

This specific feature didn't work. I must have broken it when I merged the 
patch.

I've been working on it much of the weekend and it's fixed.

As a side benefit I think I discovered one cause of those nasty "BUG: dir 
already mounted" messages which cause things to go pear shaped.

I'm going to post an appeal for help testing it in a minute.

Ian

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
