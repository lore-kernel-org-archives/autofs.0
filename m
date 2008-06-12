From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: user reporting memory leak with ldap maps
Date: Thu, 12 Jun 2008 22:13:37 +0200
Message-ID: <48518371.9060308@inria.fr>
References: <48036EE7.3070805@inria.fr>	<1208228681.3101.8.camel@raven.themaw.net>
	<48052401.4090702@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48052401.4090702@inria.fr>
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
To: autofs@linux.kernel.org

Guillaume Rousse a =E9crit :
> Ian Kent a =E9crit :
>> On Mon, 2008-04-14 at 16:49 +0200, Guillaume Rousse wrote:
>>> A mdv user complains about a memory leak in autofs 5.0.2. I can't
>>> reproduce myself, but I don't have the same version available for testi=
ng.
>>>
>>> See https://qa.mandriva.com/show_bug.cgi?id=3D39911 for full report.
>> That's quite possible but why hasn't any pertinent information been
>> obtained from the reporter?
>>
>> What are the maps in use?
>> What is the memory usage at startup, after 2 hours, 4 hours, at least
>> two samples the following day, etc. (for at least two days)?
>> Does the same thing happen if they setup file maps for everything
>> instead?
> I did ask.
The user just updated the ticket with memory usage for both file and =

ldap-based configuration.

-- =

Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
