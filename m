From: Chris Feist <cfeist@redhat.com>
Subject: Re: autofs not mounting from nis maps
Date: Wed, 16 Mar 2005 16:38:51 -0600
Message-ID: <4238B57B.6000409@redhat.com>
References: <1111004718.6120.16.camel@studio.bibu>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111004718.6120.16.camel@studio.bibu>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David <spoel@xray.bmc.uu.se>
Cc: autofs@linux.kernel.org

What version of autofs are you using on the Fedora clients?  rpm -q autofs

Also, what appears in /var/log/messages when the mounts fail?

Thanks,
Chris

David wrote:
> Hi
> 
> I have a NIS server that broadcasts an auto.XXX files as such:
> 
> [root@appel2 proc]# ypcat -k auto.master
> /home  auto.home
> /usr/local  auto.local
> /pub auto.pub
> 
> [root@appel2 proc]# ypcat -k auto.home | head -8
> magnusa  hirst:/homes/hirst/dsk1/&
> hattne   hirst:/homes/hirst/dsk2/&
> maria  hirst:/homes/hirst/dsk2/&
> diane  hirst:/homes/hirst/dsk2/&
> alina dqs1:/user13/&
> guestji hirst:/homes/hirst/dsk2/&
> hanna hirst:/homes/hirst/dsk2/&
> gunilla  bacon:/Users/&
> 
> ...
> 
> On the client side roughly half of the directories are actually mounted
> when I cd into them, the other half give:
> [root@appel2 proc]# cd /home/magnusa
> -bash: cd: /home/magnusa: No such file or directory
> 
> Without NIS everything works fine. However I have a few tens of
> workstations so it's quite tedious to update all machines with new files
> and restart autofs whenever something changes.
> 
> Am I doing something terribly wrong? Any other tips?
> 
> We are running debian on the servers and different Fedora's on the
> clients.
> 
