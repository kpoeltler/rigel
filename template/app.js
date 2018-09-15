var mainController = (function() {

	/**
	 * doSearch
	 * Processes search input from the DOM
	 * @param {}
	 */
	function doSearch() {
		$('#search_detail_div').html('Searching...');
		$('#search_div').show();

		$.getJSON("/search", { q: $('#edtsearch').val() }, function (newdata) {
			if (newdata.ok) {
				data.search = newdata;
				$('#search_detail_div').empty().append(templates.search.render(newdata));
				$('#search_table').DataTable({ "order": [ [ 6, 'desc' ] ] });
			} else {
				$('#search_detail_div').html(newdata.err);
			}
		})
	}

	/**
	 * showResult
	 * Updates the DOM to display search results, table data history
	 * @return {undefined}
	 */
	function showResult() {
		$('#detail_div').remove();
		$('#hist_div').remove();

		var main = $("#main");
		var p;
		p = $('<div/>', { id: 'detail_div' });
		p.append(templates.result.render(data));
		main.append(p);

		p = $('<div/>', { id: 'hist_div' });
		p.append(templates.history.render(data));
		main.append(p);

		$('#detail_table').DataTable({ "order": [ [ 5, 'desc' ] ] });
		$('#hist_table').DataTable({ "order": [ [ 5, 'desc' ] ] });

	}

	/**
	 * markDate
	 * Updates the DOM to display a new date for the current search log
	 * @param {string} link -
	 * @param {number} id -
	 * @returns one result
	 */
	function markDate(link, id) {
		// console.log(link.href);
		var x = data.search.search[ id ];
		if (!x.datedownload) {
			var d = new Date();
			x.datedownload = d.getFullYear() + '-' + d.getMonth() + 1 + '-' + d.getDate() + ' ' + d.getHours() + ':' + d.getMinutes() + ':00';
			$('#search_detail_div').empty().append(templates.search.render(data.search));
			$('#search_table').DataTable({ "order": [ [ 6, 'desc' ] ] });
		}

		return 1;
	}

	/**
	 * dl
	 * Maybe this assigns a new id
	 * @param {string} link -
	 * @param {number} id -
	 * @returns {number}
	 */
	function dl(link, id) {
		// console.log(link.href);
		if (id !== null) {
			var x = data.new[ id ];
			data.old.push(x);
			data.new.splice(id, 1);
			// reidx
			data.new.forEach(function (el, i) { el.idx = i; });
			data.old.forEach(function (el, i) { el.idx = i; });
		}
		showResult();

		return 1;
	}

	$(document).ready(function () {
		showResult();
		var edt = $('#edtsearch');
		edt.focus();
		edt.keyup(function (e) {
			if (e.keyCode == 13) {
				doSearch();
			}
		})
	})

});
