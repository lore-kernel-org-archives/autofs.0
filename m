From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: multiple entries with wildcards
Date: Thu, 15 Mar 2007 12:15:42 +0900
Message-ID: <1173928542.3379.3.camel@raven.themaw.net>
References: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
	<m3fy878pty.fsf@redhat.com>
	<1173919596.12589.1.camel@prometheus.workstation.sash-bielefeld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173919596.12589.1.camel@prometheus.workstation.sash-bielefeld.net>
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
To: Sascha Frey <sfrey@acs-software.de>
Cc: autofs@linux.kernel.org

On Thu, 2007-03-15 at 01:46 +0100, Sascha Frey wrote:
> On Wed, 2007-03-14 at 17:42 -0400, jmoyer@redhat.com wrote:
> > ==> Regarding [autofs] autofs5: multiple entries with wildcards; Sascha Frey <sfrey@acs-software.de> adds:
> > 
> > sfrey> Hi,
> > sfrey> I'm trying to set up autofs5, but I've got a problem:
> > 
> > sfrey> auto.master:
> > sfrey> /homes		/etc/auto.homes
> > 
> > sfrey> auto.homes:
> > sfrey> * -fstype=nfs,rw        homeserver1:/home/&
> > sfrey> * -fstype=nfs,rw        homeserver2:/home/&
> > 
> > sfrey> The directories on the first server are mounted. 
> > sfrey> But if I try to access a home which is on the second one I get a 'No
> > sfrey> such file or directory' error.
> > 
> > Your configuration is not valid.  You can use a replicated server entry,
> > but this is not the purpose for which it was intended.  Even so, it should
> > work:
> > 
> > * -fstype=nfs,rw        homeserver1,homeserver2:/home/&
> This doesn't solve my problem, because the NFS export directories are
> different on both servers (sorry, my auto.homes was just a sample).
> 
> I've seen an autofs4 setup with the maps on NIS.
> The map entries looked like this:
> #ypcat auto.home
> NFSServer:/mnt/sda1/&
> NFSServer:/mnt/sdc3/&
> NFSServer2:/mnt/users/&
> ...

But you haven't confirmed that the above NIS map is the same as what you
are using in your map.

Try using "ypcat -k auto.home" and see what the keys are.

I don't believe that and automounter will allow you to have multiple
wildcard entries.

Ian
