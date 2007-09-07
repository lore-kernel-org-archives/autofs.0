From: Ian Kent <raven@themaw.net>
Subject: Re: automount and nfs mount retry option
Date: Fri, 07 Sep 2007 10:31:23 +0800
Message-ID: <1189132283.3078.13.camel@raven.themaw.net>
References: <46DE155D.9090601@rsp.com.au>
	<10badf220709061904p478471a2g8e0c33cd9127bba6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220709061904p478471a2g8e0c33cd9127bba6@mail.gmail.com>
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
To: Shane <squindler@gmail.com>
Cc: autofs@linux.kernel.org, Anthony Menasse <anthony.menasse@rsp.com.au>

On Fri, 2007-09-07 at 11:34 +0930, Shane wrote:
> On 05/09/07, Anthony Menasse <anthony.menasse@rsp.com.au> wrote:
> > Hello,
> >
> > We had some issues the other day with an NFS server under high load and
> > clients which were attempting to automount the NFS shares timing out on
> > the mount attempts. This surprised me as we use the nfs mount option
> > "retry=2" in our auto.master file, which I assumed mean't clients would
> > keep retrying the mount attempt for 120 seconds.
> >
> > I decided to setup a simple test to understand what was going on which I
> > have described below.
> >
> > My questions are:
> >
> > * Should I expect the retry option to work as described in the nfs man
> > page with automount?
> >
> > * Am I misunderstanding something about how automount  works with with
> > the retry option?
> >
> > * Is my test method ok?
> >
> > I have attached the automount debug output from one of my test runs. Any
> > feedback is much appreciated.
> >
> > Thanks
> > Anthony
> >
> > Test setup:
> > =========
> >
> > * Server is a xen instance  running CentOS 5. Kernel  2.6.18-8.el5xen
> >
> > * 2 clients running Fedora 3 with latest autofs5 package from fc6
> > recompiled for our system ( autofs-5.0.1-0.rc3.33 ) behavior also seems
> > to occur with  Fedora 5 latest package (autofs-4.1.4-33 ) machines using
> > vanilla kernel 2.6.20.4
> >
> > * Client 1 is accessing the NFS share via a static mount
> >
> > * Client 2 is accessing the NFS share via automount with the following configuration:
> >
> > auto.master:
> >
> > /film /etc/mounts/auto.film retry=1000,nfsvers=3,fg
> 
> this is an automount operation - AFIAK options here should only be
> automount options - per the automount man page none of those are.
> ...on this note, what does automount do with those options?
> - are they passed through to each mount defined in the map? (this
> would be kinda cool as a way to define global options)
> - are they ignored?
> - if neither of above - why does automount not error or alert bad options?
> 

Read the man page again.

Options without a leading "-" are global mount options.
Most often these are appended to options found in map entries.

Ian
