From: Ian Kent <raven@themaw.net>
Subject: Re: Mount very when reboot
Date: Mon, 11 Feb 2008 17:11:56 +0900
Message-ID: <1202717516.24318.8.camel@raven.themaw.net>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
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
To: Vincent LEFORT <vincent.lefort@gmail.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-02-08 at 10:22 +0100, Vincent LEFORT wrote:
> Hello, it's my first message so be nice with me :)
> 
> I'm about 20 computers in a network with suse 10.0 x86_64. I had
> install nfs with autofs on all my computer and this works almost fine.
> 
> In fact when start, first time my computer, its well, i can connect on
> my folder and this one automount. Now if a reboot, when i try to
> access to my folder it's very slow to connect to him...
> 
> When i read /var/log/messages i can read sometimes : rpc error 5 or
> cant read superblock.
> 
> For me i think when i reboot and i'm already connected, when i reboot
> the computer, he want connect to server but server said "ho baby, i'm
> you are already connected... don't understand..."
> 
> Can you have some solutions because its very boring for user (and if
> the user put a link on their desktop the desktop will not be
> displayed...)

How about providing the information described at
http://people.redhat.com/jmoyer.

Ian
