From: Ian Kent <raven@themaw.net>
Subject: Re: How to build autofs RPM package?
Date: Wed, 30 Jun 2004 07:52:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406300750590.32407@wombat.indigo.net.au>
References: <40E1C305.7070500@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E1C305.7070500@deragon.biz>
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
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Tue, 29 Jun 2004, Hans Deragon wrote:

> Greetings.
> 
> 
>    How does one build an RPM package for autofs?  I notice that a autofs.spec is 
> provided, but no instructions.  I could fool around to get an RPM, but if there 
> is a receipe, I would like to know it and see it documented in the README file.

rpmbuild -tb autofs-4.1.3.tar.gz

man rpm

Ian
