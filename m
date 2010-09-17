From: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Subject: Re: Mount /home/* directories only with the right user
Date: Fri, 17 Sep 2010 09:26:10 +0200
Message-ID: <20100917072610.GQ13816@casco.aei.mpg.de>
References: <1280747753.4433.8.camel@kadath>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1280747753.4433.8.camel@kadath>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ricardo =?iso-8859-1?Q?P=E9rez_L=F3pez?= <ricpelo@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, Aug 02, 2010 at 01:15:53PM +0200, Ricardo P=E9rez L=F3pez wrote:
> When user (say) alice logs into the client computer, autofs exports
> her /home/alice, so it's right. However, if alice now do:
> "cd /home/bob", then autofs exports /home/bob too. I don't want that. I
> wonder if there's a way to automount a /home/* directory ONLY if you're
> the right user, i.e. alice should only get /home/alice and bob should
> only get /home/bob.

And what should happen if both alice and bob are logged in?
In that case, both directories would be auto-mounted, and nothing
would prevent them to cd to the other's $HOME.

> (For another unrelated question, all the /home/* directories must have
> 777 permissions, so I'm trying to securize the access to the /home/*
> directories using automount.)

It's not unrelated. I think it's crucial.
If you don't want A to look (&more) into B's stuff then set the permissions
right.
If you need another user to have access to all of them, use a special =

group for that (with 77x permissions, then) which nobody else belongs to.

Sorry, but I can't see another solution (as long as you don't explain
what the rationale behind 777 would be)

S

-- =

Steffen Grunewald * MPI Grav.Phys.(AEI) * Am M=FChlenberg 1, D-14476 Potsdam
Cluster Admin * http://pandora.aei.mpg.de/merlin/ * http://www.aei.mpg.de/
* e-mail: steffen.grunewald(*)aei.mpg.de * +49-331-567-{fon:7233,fax:7298}
No Word/PPT mails - http://www.gnu.org/philosophy/no-word-attachments.html
