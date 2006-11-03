From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: [autofs4 patch] fix string comparison to do full
	matches
Date: Fri, 3 Nov 2006 20:04:50 -0300
Message-ID: <20061103230450.GA23284@sleipnir.redhat.com>
References: <x49odro1amh.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49odro1amh.fsf@segfault.boston.devel.redhat.com>
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
To: autofs mailing list <autofs@linux.kernel.org>

On Fri, Nov 03, 2006 at 04:30:30PM -0500, Jeff Moyer wrote:
> =

> This patch is again from Chris Feist.  Comments welcome.
> =

> +			if (strlen(mkey) =3D=3D key_len &&
> +			    strncmp(mkey, key, key_len) =3D=3D 0) {

If this was a Google interview, I'd say that doing the strncmp before
the strlen is more efficient. With equal keys it does not matter, but
with different keys strncmp will bail out in the middle of the key, on
average, and strlen will always scan the whole key. So doing strlen
and then strncmp scans 1.5 the length of the key on average, while
doing strncmp and then strlen scans 0.5 of it (with different keys,
remember).

Other than that, the patch seems to be the right thing to do. :)

F=E1bio
-- =

ex sed lex awk yacc, e pluribus unix, amem
