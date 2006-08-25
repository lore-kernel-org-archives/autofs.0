From: Ian Kent <raven@themaw.net>
Subject: Re: What is the syntax for bind mounts under autofs 5 ?
Date: Fri, 25 Aug 2006 09:21:55 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608250919030.6382@raven.themaw.net>
References: <E1GGEUO-0004FJ-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGEUO-0004FJ-00@mta2.cl.cam.ac.uk>
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
To: Piete Brooks <Piete.Brooks--autofs@cl.cam.ac.uk>
Cc: autofs@linux.kernel.org

On Thu, 24 Aug 2006, Piete Brooks wrote:

> I used to be able to use:
> 
> 	foo	:/usr/local/foo
> 
> to cause autofs to do a bind mount of "foo" to the local directory 
> /usr/local/foo but under autofs 5 it fails. With "automount -d -v" I get:
> 
> Aug 24 13:36:21 pbtest8 automount[3657]: attempting to mount entry /mount/foo
> Aug 24 13:36:21 pbtest8 automount[3657]: failed to mount /mount/foo

Your not getting all the log info.

Have you got something like:

daemon.*                                         /var/log/debug

in syslog.conf

Ian
