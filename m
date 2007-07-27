From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Fri, 27 Jul 2007 17:45:30 +0200
Message-ID: <1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185550740.3203.80.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,
> 
> I'll have to think about for a while and have a look at the code.

Thank you :)

> What does your auto_homes look like?

ypmatch is my friend:

lkolbe@komagatake ypmatch lkolbe auto_homes
figaro:/users/rbghiwis01/rbghiwis/&
lkolbe@komagatake ypmatch fstest auto_homes
thor:/export/rbg/homes/staff/&
lkolbe@komagatake ypmatch vkgnome auto_homes
figaro:/users/stud09/stud/&

Where figaro is a Solaris 8 or 9 server serving nfs3, thor is a solaris
10 box serving nfs4 from zfs-volumes.

> What version of autofs and kernel?
> 
I currently tried it for testing on linux 2.6.18 (ubuntu dapper), autofs
5.0.2 (backported from debian experimental). That would be the
production environment for a few more months :)

> Ian
> 

-- 
Lukas
