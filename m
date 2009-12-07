From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: How to make Autofs check if ldap server is back online
Date: Mon, 07 Dec 2009 23:10:58 +0100
Message-ID: <4B1D7D72.2050205@inria.fr>
References: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Eric B." <ebenze@hotmail.com>, autofs@linux.kernel.org

Eric B. a =E9crit :
> Is there anything I can do to force autofs to check to see if my LDAP ser=
ver
> is back online?
If you have some kind of automated configuration management software, =

such as cfengine or puppet, you can monitor status of ldap-based mount =

maps periodically.

However, if you use those tools, you may as well distribute plain old =

file-based mount maps, than never fail.

-- =

BOFH excuse #311:

transient bus protocol violation
