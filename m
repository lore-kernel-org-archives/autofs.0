From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mounting certain home directories for no reason
Date: Fri, 20 Mar 2009 10:32:30 +0900
Message-ID: <49C2F22E.5020205@themaw.net>
References: <49BEE94A.1000608@lhup.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49BEE94A.1000608@lhup.edu>
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
To: Krish Pillai <kpillai@lhup.edu>
Cc: autofs@linux.kernel.org

Krish Pillai wrote:
> I just upgraded from Fedora 8 to Fedora 10 
> (2.6.27.19-170.2.35.fc10.x86_64) on some of my machines and autofs seems 
> to be acting up. My server is running fc7.
> I have ypbind and automount running on all clients and the clients seem 
> to be repeatedly sending mount/umount  requests to the server on behalf 
> of users who are not even trying to log in. As a result I see home 
> directories getting mounted on the clients and getting unmounted all the 
> time. Is this a known problem? If so, is there a fix?

I'm not aware of a problem.

You probably should collect information as described at 
http://people.redhat.com/jmoyer and log a bug. The debug log and autofs 
maps are probably the most important bits initially.

Ian
