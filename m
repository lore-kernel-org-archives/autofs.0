From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: user reporting memory leak with ldap maps
Date: Tue, 15 Apr 2008 23:54:09 +0200
Message-ID: <48052401.4090702@inria.fr>
References: <48036EE7.3070805@inria.fr>
	<1208228681.3101.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1208228681.3101.8.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

Ian Kent a =E9crit :
> On Mon, 2008-04-14 at 16:49 +0200, Guillaume Rousse wrote:
>> A mdv user complains about a memory leak in autofs 5.0.2. I can't
>> reproduce myself, but I don't have the same version available for testin=
g.
>>
>> See https://qa.mandriva.com/show_bug.cgi?id=3D39911 for full report.
> =

> That's quite possible but why hasn't any pertinent information been
> obtained from the reporter?
> =

> What are the maps in use?
> What is the memory usage at startup, after 2 hours, 4 hours, at least
> two samples the following day, etc. (for at least two days)?
> Does the same thing happen if they setup file maps for everything
> instead?
I did ask.

> What process did you follow when trying to reproduce it?
> =

> As far as the version goes I don't know what may have been added to make
> up that package.
If you're refering to mandriva specific modifications, everything is
available at
http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/autofs/releases/=
5.0.2/8mdv2008.1/

Most patches are upstream patches, excepted the following ones:
Patch101:       autofs-5.0.2-set-default-browse-mode.patch
Patch102:       autofs-5.0.2-separate-config-files.patch
Patch103:       autofs-5.0.2-rename-configuration-file.patch
Patch105:       autofs-5.0.1-rc3-comment-default-master-map.patch
-- =

Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
