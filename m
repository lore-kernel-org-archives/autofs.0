From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs breaking nfs4 protocol by sending udp probes ?
Date: Thu, 31 Jan 2008 18:42:21 +0100
Message-ID: <47A2087D.6090302@inria.fr>
References: <478F7969.4080209@inria.fr>	
	<1200967695.3078.1.camel@raven.themaw.net>
	<1201152804.3061.28.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1201152804.3061.28.camel@raven.themaw.net>
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

Ian Kent a =E9crit :
> On Tue, 2008-01-22 at 11:08 +0900, Ian Kent wrote:
>> On Thu, 2008-01-17 at 16:51 +0100, Guillaume Rousse wrote:
>>> According to nfs4 developpers, autofs is suspect there:
>>> http://linux-nfs.org/pipermail/nfsv4/2007-December/007332.html
>> Please try this patch and let me know how it goes.
> =

> This one isn't right.
> Can you try this one instead please.
> http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.3-nfs4-tcp-o=
nly.patch
Works OK, thanks again.
-- =

Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
