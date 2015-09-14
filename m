From: "Cyril B." <cbay@excellency.fr>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 11:29:38 +0200
Message-ID: <55F69382.2060605@excellency.fr>
References: <55F58085.4090509@excellency.fr> <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr> <55F69162.5080601@embl-heidelberg.de>
Reply-To: cbay@excellency.fr
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:Reply-To:From:Date:Message-ID; bh=qx4I1hhSegsU2TCmEYOAf7qO0hix/S7AtvpLjZ1xgjM=;
	b=EVw3LdHL4wXchbh5TcFiuU/Q7b6nImBN5IvGEwT5R9ayhWobn2D3tYKwrHOH8c6SwUGI6HQOMzog/yzK1e5VFFxbQy6EUD+9LN5EwlQKKelsD2zhLt5ZwVuzbzkWVIbVwAlBeoCtC/Waw+WVW4/9R2FkslS96H/wVSNpVkFkxh85cJWwWSaQ1M91IhsNjU5eVtX2ewlCEhgNp07gYOvMKh/KFisaMD8bnS7jWLaX/sXjm0TRrunphehnXR0ML7llHjnIz/PjOC3z1ADnhk9pG/mmf3YUhuCrvf3lZp9yji9zETqsSEYYi8fiU8PUauB9zvLIYQfNXhWWa6SrU/ZQwA==;
In-Reply-To: <55F69162.5080601@embl-heidelberg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Frank Thommen <frank.thommen@embl-heidelberg.de>
Cc: Ian Kent <raven@themaw.net>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Frank Thommen wrote:
> They are not "re"set.  These are the permissions of the filesystem that
> you are mounting over /home (e.g. myfileserver:/export/homes).  Change
> the permissions of /export/homes on myfileserver.

In my case, I haven't mounted anything at all yet. My map is an 
executable, and since I haven't triggered an automatic mount (by 
accessing /home/foo), the executable has not even been called once. 
/home is empty.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
