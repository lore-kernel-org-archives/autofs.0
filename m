From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs hang, centos 4.4
Date: Sun, 19 Nov 2006 01:51:12 +0800
Message-ID: <1163872272.2973.5.camel@localhost>
References: <455C8BA8.9070609@soe.ucsc.edu>
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
	<455CB5F6.9040201@soe.ucsc.edu>  <1163749264.2993.67.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163749264.2993.67.camel@localhost>
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

On Fri, 2006-11-17 at 15:41 +0800, Ian Kent wrote:
> On Thu, 2006-11-16 at 11:03 -0800, Erich Weiler wrote:
> > My autofs maps are served by our OpenLDAP server.  The map that has the 
> > problem (because sometimes it tries to reference NFS servers outside our 
> > private network) is /projects.  From the auto.master entry in LDAP:
> > 
> > nisMapName: auto.master
> > nisMapEntry: ldap:nisMapName=auto.projects,dc=kilokluster,dc=ucsc,dc=edu 
> > -browse,hard,intr,rw

Umm.

Browsable map. It may be possible it's not catching Ctrl-C.

I'll check.

And the user shell is?

Ian
