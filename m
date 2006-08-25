From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: unable to locate ldap master map
Date: Fri, 25 Aug 2006 19:15:00 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608251913370.30523@raven.themaw.net>
References: <E1GGXbO-0000MZ-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGXbO-0000MZ-00@mta2.cl.cam.ac.uk>
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
To: Piete Brooks <Piete.Brooks@cl.cam.ac.uk>, Piete.Brooks--autofs@cl.cam.ac.uk
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 25 Aug 2006, Piete Brooks wrote:

> 
> OK -- put it down to a "simplistic user view of the problem" :-(
> I was thinking you could do something equiv to
> 
> (|(&(objectclass=automountMap)(ou=auto.master))
>   (&(objectclass=nisMap)(nisMapName=auto.master))
> )

That query would work but then we would no be able to use arbitary schema 
in the configuration.

Ian
