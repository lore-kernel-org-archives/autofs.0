From: raven@themaw.net
Subject: Re: Autofs picking first server from the automounter map
 all the time
Date: Sun, 2 May 2004 22:01:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405022157060.25614@donald.themaw.net>
References: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
	<4092BC7D.2080703@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4092BC7D.2080703@sedona.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, "Patel, Rahulkumar [NJ]" <rahul@lehman.com>

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
